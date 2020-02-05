import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  TextEditingController bidAmountCtrl = TextEditingController();

  String getBidAmount() {
    return bidAmountCtrl.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16, left: 16),
          child: Text(
            'Enter price to bid on',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: TextField(
            controller: bidAmountCtrl,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: 'e.g. 0.01',
                hintStyle: TextStyle(color: Colors.black45),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38))),
          ),
        ),
      ],
    );
  }
}