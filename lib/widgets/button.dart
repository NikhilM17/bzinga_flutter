import 'package:bzinga/widgets/text.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String title;
  final GestureTapCallback onPressed;

  ButtonWidget({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: RaisedButton(
        child: TextWidget(content: title),
        textColor: Colors.white,
        color: Colors.blueAccent,
        onPressed: onPressed,
      ),
    );
  }
}
