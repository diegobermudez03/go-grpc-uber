import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{

  final void Function()? callback;
  final String text;

  const MyButton({
    super.key,
    required this.callback,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: callback, 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)
              ),
              child: Container(
                margin: EdgeInsets.all(16),
                child: Text(text)
              )
            );
  }
}