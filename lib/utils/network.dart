import 'dart:convert';

import 'package:bzinga/auctions/model/bid.dart';
import 'package:bzinga/utils/sharedPrefs.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class HttpClientHelper {
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

  Future<String> postRegisterMobileNumber(String encode) async {
    Response res = await http.post(Constants.REGISTER_MOBILE_NUMBER,
        headers: getHeaders(), body: encode);
    return res.statusCode == 200 ? res.body : "";
  }

  Future<String> verifyOTP(String encode) async {
    Response res = await http.post(Constants.VERIFY_OTP,
        headers: getHeaders(), body: encode);
    return res.statusCode == 200 ? res.body : "";
  }

  Future<String> getAuctions() async {
    var url = Constants.AUCTIONS;
    Response res = await http.get(url, headers: getHeaders());
    return res.statusCode == 200 ? res.body : "";
  }

  Future<String> postBids(BidRequestBody body) async {
    TOKEN = await SharedPrefs().getToken();
    var jsonString = json.encode(body);
    Response res =
        await http.post(Constants.BID, headers: getHeaders(), body: jsonString);
    return res.statusCode == 200 ? res.body : "";
  }
}

class HttpListener<T> {
  void response(String response) {}

  void message(String message) {}
}
