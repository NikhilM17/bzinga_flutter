import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/network/apis.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuctionsViewModel extends Model {
  Future<List<Auction>> _auctions;
  final AuctionsApi auctionsApi;

  AuctionsViewModel({@required this.auctionsApi});

  Future<List<Auction>> get auctions => _auctions;

  set auctions(Future<List<Auction>> value) {
    _auctions = value;
    notifyListeners();
  }

  Future<bool> setAuctions() async {
    auctions = auctionsApi.getAuctionsList();
    return auctions != null;
  }
}