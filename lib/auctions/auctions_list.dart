import 'dart:convert';
import 'package:bzinga/auctions/auction_panel.dart';
import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/auctions/model/bid.dart';
import 'package:bzinga/auctions/model/bidding_response.dart';
import 'package:bzinga/auctions/view_models/auctions_view_model.dart';
import 'package:bzinga/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class Auctions extends StatefulWidget {
  AuctionsViewModel viewModel;

  Auctions({Key key, @required this.viewModel}) : super(key: key);

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

  Future getAuctions() async {
    await widget.viewModel.setAuctions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('Auctions')),
      body: ScopedModel<AuctionsViewModel>(
        model: widget.viewModel,
        child: AuctionsPanel(),
      ),
    );
  }
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
    var data = json.decode(response);
    BiddingResponse biddingResponse = BiddingResponse.fromJson(data);
    if (biddingResponse != null) {
      showToast(biddingResponse.data.remainingCoins);
    }
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);
}

Widget getTextView(String error) {
  return Center(child: Text(error));
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