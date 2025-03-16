import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/presentation/bloc/live_bloc.dart';

class LivePage extends StatefulWidget{
  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  int xPos = 0;
  int yPos = 0;


  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LiveBloc>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(flex: 5),
            Text("Position: ($xPos, $yPos)", style: TextStyle(fontSize: 30),),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: MoveButton(
                callback: yPos >= 10 ? null :(){
                  yPos++;
                  bloc.updatePosition(xPos, yPos);
                  setState(() {});
                }, 
                icon: Icons.arrow_circle_up_rounded
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MoveButton(
                  callback: xPos <= 1 ? null :(){
                    xPos--;
                    bloc.updatePosition(xPos, yPos);
                    setState(() {});
                  }, 
                  icon: Icons.arrow_circle_left_outlined
                ),
                MoveButton(
                  callback: xPos >= 10 ? null :(){
                    xPos++;
                    bloc.updatePosition(xPos, yPos);
                    setState(() {});
                  }, 
                  icon: Icons.arrow_circle_right_outlined
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: MoveButton(
                callback: yPos <= 1 ? null :(){
                  yPos--;
                  bloc.updatePosition(xPos, yPos);
                  setState(() {});
                }, 
                icon: Icons.arrow_circle_down_rounded
              ),
            ),
            const Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }

}


class MoveButton extends StatelessWidget{

  final void Function()? callback;
  final IconData icon;

  const MoveButton({
    super.key,
    required this.callback,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondaryContainer)
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Icon(icon, size: 50,)
      ),
    );
  }
}