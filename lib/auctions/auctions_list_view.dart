import 'package:bzinga/auctions/auctions_main.dart';
import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/auctions/tabs/range_bid.dart';
import 'package:bzinga/auctions/tabs/single_bid.dart';
import 'package:bzinga/widgets/countdown_timer.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AuctionsListView extends StatelessWidget {
  List<Auction> auctions;
  int currentTab = 0;
  FirstScreen firstScreen;
  SecondScreen secondScreen;

  AuctionsListView(
      {this.auctions, this.currentTab, this.firstScreen, this.secondScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(4),
        itemCount: auctions.length,
        itemBuilder: (context, index) {
          return FlipCard(
              front: getFrontAction(auctions, index),
              back: getSecondaryAction(
                  currentTab, firstScreen, secondScreen, index, auctions));
        });
  }
}

Widget getFrontAction(List<Auction> auctions, int index) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.network(auctions.elementAt(index).product.productImage,
                height: 200, width: 200),
          ),
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      auctions.elementAt(index).product.productName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      auctions.elementAt(index).product.productDescription,
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
  );
}

Widget getSecondaryAction(int currentTab, FirstScreen firstScreen,
    SecondScreen secondScreen, int index, List<Auction> auctions) {
  return Container(
    height: 260,
    color: Colors.white,
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Colors.white,
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
                  labelStyle: TextStyle(fontWeight: FontWeight.w700),
                  tabs: [Tab(text: "Single"), Tab(text: 'Bid Range')],
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
                }
              },
              child: Text('BID NOW'),
            ),
          ),
        )
      ],
    ),
  );
}
