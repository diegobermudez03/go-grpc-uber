import 'package:flutter/material.dart';

class MyField extends StatelessWidget{
  
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;

  const MyField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder()
              ),
              onChanged: onChanged,
            );
  }
}