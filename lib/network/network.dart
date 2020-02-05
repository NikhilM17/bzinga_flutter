import 'dart:convert';

import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/auctions/model/bid.dart';
import 'package:bzinga/authentication/models/registerMobileNumber.dart';
import 'package:bzinga/network/apis.dart';
import 'package:bzinga/utils/sharedPrefs.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class HttpClientHelper implements AuctionsApi {
  static String TOKEN = "";

  static getHttp(String url) {
    return http.get(url, headers: getHeaders());
  }

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + TOKEN
    };
    return headers;
  }

  Future<MobileRegisterResponse> postRegisterMobileNumber(String encode) async {
    Response response = await http.post(Constants.REGISTER_MOBILE_NUMBER,
        headers: getHeaders(), body: encode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MobileRegisterResponse.fromJson(data);
    } else {
      throw Exception('Failed to register mobile number');
    }
    //return res.statusCode == 200 ? res.body : "";
  }

  Future<String> verifyOTP(String encode) async {
    Response res = await http.post(Constants.VERIFY_OTP,
        headers: getHeaders(), body: encode);
    return res.statusCode == 200 ? res.body : "";
  }

  Future<List<Auction>> getAuctions() async {
    var url = Constants.AUCTIONS;
    Response response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      AuctionsData data = AuctionResponse.fromJson(map).data;
      return data != null ? data.auctions : null;
    } else {
      throw Exception('Failed to fetch auctions');
    }
    //return res.statusCode == 200 ? res.body : "";
  }

  Future<String> postBids(BidRequestBody body) async {
    TOKEN = await SharedPrefs().getToken();
    var jsonString = json.encode(body);
    Response res =
        await http.post(Constants.BID, headers: getHeaders(), body: jsonString);
    return res.statusCode == 200 ? res.body : "";
  }

  @override
  Future<List<Auction>> getAuctionsList() async {
    var url = Constants.AUCTIONS;
    Response response = await http.get(url, headers: getHeaders());
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      AuctionsData data = AuctionResponse.fromJson(map).data;
      return data != null ? data.auctions : null;
    } else {
      throw Exception('Failed to fetch auctions');
    }
  }
}

class HttpListener<T> {
  void response(String response) {}

  void message(String message) {}
}
