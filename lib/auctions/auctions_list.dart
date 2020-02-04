import 'dart:convert';
import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/auctions/model/bid.dart';
import 'package:bzinga/auctions/model/bidding_response.dart';
import 'package:bzinga/constants.dart';
import 'package:bzinga/utils/network.dart';
import 'package:bzinga/widgets/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auctions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuctionsState();
  }
}

void showToast(String mesg) {
  Fluttertoast.showToast(msg: mesg, gravity: ToastGravity.BOTTOM);
}

class AuctionsState extends State<Auctions> {
  List<Auction> list;

  @override
  void initState() {
    super.initState();
    getAuctions();
  }

  void getAuctions() async {
    String response = await HttpClientHelper().getAuctions();

    if (response != null && response.isNotEmpty) {
      setState(() {
        AuctionResponse data = AuctionResponse.fromJson(json.decode(response));
        if (data != null) {
          setState(() {
            list = data.data.auctions;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Auctions'),
      ),
      //body: getListView(),
      body: list != null && list.isNotEmpty ? getListView(list) : getTextView(),
    );
  }
}

Widget getListView(List<Auction> auctions) {
  int currentTab = 0;
  FirstScreen firstScreen = FirstScreen();
  SecondScreen secondScreen = SecondScreen();
  /*Product product = new Product(
      id: "101",
      productName: "Laptop",
      productDescription: "Batter Backup",
      productImage:
          "https://www.lenovo.com/medias/lenovo-flex-5-15-intel-black-hero.png?context=bWFzdGVyfHJvb3R8MjYzMTQ1fGltYWdlL3BuZ3xoMmQvaGZkLzk5Nzk1MTQ4ODAwMzAucG5nfDNlZWRlNGIwYTc5MjAyNjkzNDkzNTg2MWY0MjkzZDQ5N2E2MWJjOTk1Y2M5ZDJjZGIyNzRhYTE0OGFlYmE4MGE");
  Auction auction = new Auction(
      id: "1",
      auctionStartTime: "2020-01-28 12:33:41.167Z",
      auctionEndTime: "2020-01-29 12:33:41.167Z",
      product: product);

  auctions.add(auction);*/

  return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: auctions.length,
      itemBuilder: (context, index) {
        return Slidable(
            secondaryActions: <Widget>[
              Card(
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          appBar: TabBar(
                            onTap: (index) {
                              currentTab = index;
                            },
                            labelColor: Color(0xFF7E57D1),
                            unselectedLabelColor: Colors.black54,
                            tabs: [
                              Tab(
                                text: "Single",
                              ),
                              Tab(
                                text: 'Bid Range',
                              )
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              firstScreen,
                              secondScreen,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              Auction auction = auctions.elementAt(index);
                              if (auction != null) {
                                if (currentTab == 0) {
                                  String bidAmount = firstScreen.getBidAmount();
                                  singleBid(bidAmount, auction);
                                }
                              } else {}
                            },
                            child: Text('BID NOW'),
                          ),
                        ))
                  ],
                ),
              ),
            ],
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.90,
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
            ));
      });
}

void singleBid(String bidAmount, Auction auction) async {
  var body = BidRequestBody(
    auctionId: auction.id,
    productId: auction.product.id,
    interval: "0.01",
    bidAmount: bidAmount,
    bidRangeMax: "0",
    bidRangeMin: "0",
    bidsPlacedCount: "",
    showId: auction.showId != null ? auction.showId : "",
  );
  String response = await HttpClientHelper().postBids(body);
  if (response != null && response.isNotEmpty) {
    BiddingResponse biddingResponse =
        BiddingResponse.fromJson(json.decode(response));
    if (biddingResponse != null) {
      showToast(biddingResponse.data.remainingCoins);
    }
  }
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

Widget getTabText(String title) {
  return Text(title, style: TextStyle());
}

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
