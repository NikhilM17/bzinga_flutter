import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  String content;
  Color textColor;
  String font;
  double fontSize;
  bool setBold = false;

  TextWidget({
    this.content,
    this.fontSize = 0,
    this.textColor,
    this.font,
    this.setBold: false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        content,
        style: TextStyle(
            fontSize: (fontSize > 0) ? fontSize : 16,
            color: textColor != null ? textColor : Colors.white,
            fontFamily: (font != null && font.isNotEmpty) ? font : 'Raleway',
            fontWeight: setBold ? FontWeight.w700 : FontWeight.w400),
      ),
    );
  }
}
