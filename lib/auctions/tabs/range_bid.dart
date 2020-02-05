import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  double textFieldWidth;
  TextEditingController startCtrl, incrementCtrl, noOfBidsCtrl;

  String getBidAmount() {
    return startCtrl.text;
  }

  String getIncremental() {
    return incrementCtrl.text;
  }

  String getNoOfBids() {
    return noOfBidsCtrl.text;
  }

  @override
  Widget build(BuildContext context) {
    textFieldWidth = (MediaQuery.of(context).size.width - 110) / 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, bottom: 24),
          child: Text(
            'Maximum 100 bids can be placed at a time',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'START BID',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  width: textFieldWidth,
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'e.g. 0.01',
                      hintStyle: TextStyle(color: Colors.black45),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'INCREMENT',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  width: textFieldWidth,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'e.g. 0.01',
                      hintStyle: TextStyle(color: Colors.black45),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                size: 16,
                color: Colors.black38,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'NO. OF BIDS',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  width: textFieldWidth,
                  padding: EdgeInsets.only(left: 8, right: 16),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'e.g. 0.01',
                      hintStyle: TextStyle(color: Colors.black45),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}