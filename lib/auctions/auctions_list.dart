import 'dart:convert';
import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/constants.dart';
import 'package:bzinga/widgets/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Auctions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuctionsState();
  }
}

class AuctionsState extends State<Auctions> {
  List<Auction> list;

  @override
  void initState() {
    super.initState();
    getAuctions();
  }

  void getAuctions() async {
    var url = Constants.AUCTIONS;

    Response res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      print(json.decode(res.body));
      AuctionResponse data = AuctionResponse.fromJson(json.decode(res.body));
      if (data != null) {
        setState(() {
          list = data.data.auctions;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Auctions'),
      ),
      body: list != null && list.isNotEmpty ? getListView(list) : getTextView(),
    );
  }
}

Widget getListView(List<Auction> auctions) {
  return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                        auctions.elementAt(index).product.productImage,
                        height: 200,
                        width: 200),
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              auctions.elementAt(index).product.productName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              auctions
                                  .elementAt(index)
                                  .product
                                  .productDescription,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CountDownTimer(
                          secondsRemaining: getTimeLeft(
                              auctions.elementAt(index).auctionStartTime,
                              auctions.elementAt(index).auctionEndTime),
                          countDownTimerStyle: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Widget getTextView() {
  return Center(child: Text('No Auctions'));
}

int getTimeLeft(String startTime, String endTime) {
  var start = DateTime.parse(startTime);
  var end = DateTime.parse(endTime);
  Duration duration = end.difference(start);
  return duration.inSeconds;
}
