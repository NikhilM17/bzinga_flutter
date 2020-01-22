import 'dart:async';
import 'package:bzinga/constants.dart';
import 'package:http/http.dart' as http;

class API {
  static Future getLanguages() {
    var url = Constants.BASE_URL + Constants.LANGUAGES;
    return http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  }
}
