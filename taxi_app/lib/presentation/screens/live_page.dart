import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/presentation/bloc/live_bloc.dart';

class LivePage extends StatefulWidget {
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: BlocListener<LiveBloc, LiveState>(
            listener: (context, state) {
              if (state is LiveRequestState) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: FittedBox(
                          child: Column(
                            children: [
                              Text("Cliente : ${state.clientName}"),
                              Text("Posicion (${state.position.xPosition}, ${state.position.yPosition})"),
                              Text("Distancia: ${state.distance}"),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                bloc.denyRequest();
                                Navigator.of(context).pop();
                              },
                              child: Text("Rechazar")),
                          TextButton(
                              onPressed: () {
                                bloc.acceptRequest();
                                Navigator.of(context).pop();
                              },
                              child: Text("Aceptar"))
                        ],
                      );
                    });
              }
            },
            child: BlocBuilder<LiveBloc, LiveState>(
              builder: (context, state) {
                Widget header = Container();
                if(state is LiveInCourse){
                  header = Container(
                    padding: const EdgeInsets.all(16),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                        "En curso: Cliente ${state.clientName} Posicion (${state.position.xPosition}, ${state.position.yPosition})",
                        style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return Column(
                  children: [
                    header,
                    const Spacer(flex: 5),
                    Text(
                      "Position: ($xPos, $yPos)",
                      style: TextStyle(fontSize: 30),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: MoveButton(
                          callback: yPos >= 10
                              ? null
                              : () {
                                  yPos++;
                                  bloc.updatePosition(xPos, yPos);
                                  setState(() {});
                                },
                          icon: Icons.arrow_circle_up_rounded),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MoveButton(
                            callback: xPos <= 1
                                ? null
                                : () {
                                    xPos--;
                                    bloc.updatePosition(xPos, yPos);
                                    setState(() {});
                                  },
                            icon: Icons.arrow_circle_left_outlined),
                        MoveButton(
                            callback: xPos >= 10
                                ? null
                                : () {
                                    xPos++;
                                    bloc.updatePosition(xPos, yPos);
                                    setState(() {});
                                  },
                            icon: Icons.arrow_circle_right_outlined),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: MoveButton(
                          callback: yPos <= 1
                              ? null
                              : () {
                                  yPos--;
                                  bloc.updatePosition(xPos, yPos);
                                  setState(() {});
                                },
                          icon: Icons.arrow_circle_down_rounded),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MoveButton extends StatelessWidget {
  final void Function()? callback;
  final IconData icon;

  const MoveButton({super.key, required this.callback, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.secondaryContainer)),
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Icon(
            icon,
            size: 50,
          )),
    );
  }
}
