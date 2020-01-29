import 'dart:convert';

import 'package:bzinga/authentication/models/termConditions.dart';
import 'package:bzinga/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:html/dom.dart' as dom;

class TermsAndConditions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TermsAndConditionsState();
  }
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  String content = "";

  void getTermsAndConditions() async {
    var url = Constants.TERMS_AND_CONDITIONS;

    Response res =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
      print(json.decode(res.body));
      TCModel model = TCModel.fromJson(json.decode(res.body));
      if (model != null) {
        setState(() {
          content = model.terms.value;
        });
      } else {}
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getTermsAndConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            child: SingleChildScrollView(
              child: Text(
                (Uri.dataFromString(content, mimeType: 'text/html').toString()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
