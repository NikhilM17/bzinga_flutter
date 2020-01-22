import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String hint;
  Color hintColor;
  TextInputType inputType;

  TextFieldWidget({this.hint, this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: hintColor),
        ),
      ),
    );
  }
}