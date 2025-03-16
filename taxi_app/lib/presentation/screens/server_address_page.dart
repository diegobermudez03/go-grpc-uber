

import 'package:flutter/material.dart';
import 'package:taxi_app/presentation/global_state.dart';
import 'package:taxi_app/presentation/screens/registration_page.dart';

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
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: "10.0.2.2:9000",
                border: OutlineInputBorder()
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (){
                if(addressController.text.isNotEmpty){
                  GlobalContext.grpcServerAddress = addressController.text;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx)=>RegistrationPage()
                  )
                );
              }, 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)
              ),
              child: Container(
                margin: EdgeInsets.all(16),
                child: Text("Continuar")
              )
            ),
            const Spacer(flex: 3,),
          ],
        ),
      ),
    );
  }
}