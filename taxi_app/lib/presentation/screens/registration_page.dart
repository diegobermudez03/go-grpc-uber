import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/presentation/bloc/live_bloc.dart';
import 'package:taxi_app/presentation/bloc/registration_bloc.dart';
import 'package:taxi_app/presentation/screens/live_page.dart';
import 'package:taxi_app/presentation/widgets/my_button.dart';
import 'package:taxi_app/presentation/widgets/my_field.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController serviceController;
  late final TextEditingController placaController;
  bool ableToSend = false;

  @override
  void initState() {
    serviceController = TextEditingController();
    placaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    serviceController.dispose();
    placaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistraionState>(
        listener: (context, state) {
          if(state is RegistrationError){
            showDialog(
              context: context, 
              builder: (ctx)=>AlertDialog(
                content: Text(state.message),
              )
            );
          }else if(state is RegistrationSuccess){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx)=> BlocProvider(
                  create: (ctx) => GetIt.instance.get<LiveBloc>(),
                  child: LivePage(),
                )
              )
            );
          }
        },
        child: BlocBuilder<RegistrationBloc, RegistraionState>(builder: (ctx, state) {
          final bloc = BlocProvider.of<RegistrationBloc>(context);
          final Widget button;
          if(state is RegistrationLoading){
            button = CircularProgressIndicator();
          }else{
            button = MyButton(
              callback: ableToSend? () => bloc.registrate(placaController.text, serviceController.text): null, 
              text: "Continuar"
            );
          }
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(flex: 10,),
                Text(
                    "Escribe tu tipo de servicio (si es invalido se tomara Normal por defecto): \"Normal\" \"Express\" \"Excursion\""),
                const Spacer(),
                MyField(
                  controller: serviceController, 
                  hintText: "Normal",
                  onChanged: (_)=>checkIfAble(),
                ),
                const Spacer(flex: 5,),
                Text("Escribe tu placa"),
                const Spacer(),
                MyField(
                  controller: placaController,
                  hintText: "XXX111",
                  onChanged: (_)=>checkIfAble(),
                ),
                const Spacer(),
                button,
                const Spacer(flex: 10,),
              ],
            ),
          );
        }),
      ),
    );
  }

  void checkIfAble() {
    final before = ableToSend;
    if (serviceController.text.isNotEmpty && placaController.text.isNotEmpty) {
      ableToSend = true;
    } else {
      ableToSend = false;
    }
    if(before != ableToSend){
      setState(() {
        
      });
    }
  }
}
