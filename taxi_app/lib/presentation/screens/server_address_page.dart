

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:taxi_app/presentation/bloc/live_bloc.dart';
import 'package:taxi_app/presentation/bloc/registration_bloc.dart';
import 'package:taxi_app/presentation/global_state.dart';
import 'package:taxi_app/presentation/screens/registration_page.dart';
import 'package:taxi_app/presentation/widgets/my_button.dart';
import 'package:taxi_app/presentation/widgets/my_field.dart';
import 'package:taxi_app/repository/grpc_repository.dart';

class ServerAddressPage extends StatefulWidget{
  @override
  State<ServerAddressPage> createState() => _ServerAddressPageState();
}

class _ServerAddressPageState extends State<ServerAddressPage> {
  late final TextEditingController addressController;

  @override
  void initState() {
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Spacer(flex: 3,),
            Text(
              "Ingresa la direccion del servidor gRPC con puerto (si deja en blanco se toma 10.0.2.2:9000)",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            MyField(controller: addressController, hintText: "10.0.2.2:9000",),
            const Spacer(),
            MyButton(
              callback: (){
                injectDependencies();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx)=>  BlocProvider(
                      create: (context) => GetIt.instance.get<RegistrationBloc>(),
                      child: RegistrationPage(),
                    )
                  )
                );
              },
              text: "continuar",
            ),
            const Spacer(flex: 3,),
          ],
        ),
      ),
    );
  }

  void injectDependencies(){
    if(addressController.text.isNotEmpty){
      GlobalContext.grpcServerAddress = addressController.text;
    }
    final getIt = GetIt.instance;
    final parts = GlobalContext.grpcServerAddress.split(":");
    final channel = ClientChannel(
      parts[0],
      port: int.parse(parts[1]),
      options: const ChannelOptions(credentials: ChannelCredentials.insecure())
    );
  
    getIt.registerSingleton(GrpcRepository(channel));

    getIt.registerLazySingleton(()=>RegistrationBloc(getIt.get()));
    getIt.registerLazySingleton(()=>LiveBloc(getIt.get()));
  }
}