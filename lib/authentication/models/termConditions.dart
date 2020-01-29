import 'dart:core';

class TCModel {
  int status;
  TC terms;

  TCModel({this.status, this.terms});

  factory TCModel.fromJson(Map<String, dynamic> json) => new TCModel(
      status: json['status'],
      terms: json.containsKey('data') ? TC.fromJson(json['data']) : null);
}

class TC {
  String key;
  String value;

  TC({this.value, this.key});

  factory TC.fromJson(Map<String, dynamic> json) =>
      new TC(value: json['value'], key: json['key']);
}
