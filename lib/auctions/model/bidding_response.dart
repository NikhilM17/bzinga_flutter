class BiddingResponse {
  int status;
  String message;
  Data data;

  BiddingResponse({this.status, this.message, this.data});

  factory BiddingResponse.fromJson(Map<String, dynamic> json) =>
      new BiddingResponse(
        status: json['status'],
        message: json.containsKey('message') ? json['message'] : "",
        data: json.containsKey('data') ? Data.fromJson(json['data']) : null,
      );
}

class Data {
  String remainingCoins;

  Data({this.remainingCoins});

  factory Data.fromJson(Map<String, dynamic> json) =>
      new Data(remainingCoins: json['remainingCoins']);
}
