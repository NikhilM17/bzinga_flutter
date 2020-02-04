class BidRequestBody {
  String auctionId;
  String productId;
  String showId;
  String bidAmount;
  String bidRangeMin;
  String bidRangeMax;
  String interval;
  String bidsPlacedCount;

  BidRequestBody(
      {this.auctionId,
      this.productId,
      this.showId,
      this.bidAmount,
      this.bidRangeMin,
      this.bidRangeMax,
      this.interval,
      this.bidsPlacedCount});

  factory BidRequestBody.fromJson(Map<String, dynamic> json) =>
      new BidRequestBody(
        auctionId: json['auctionId'],
        productId: json['productId'],
        showId: json['showId'],
        bidAmount: json['bidAmount'],
        bidRangeMin: json['bidRangeMin'],
        bidRangeMax: json['bidRangeMax'],
        interval: json['interval'],
        bidsPlacedCount: json['bidsPlacedCount'],
      );

  Map<String, dynamic> toJson() => {
        "auctionId": auctionId,
        "productId": productId,
        "showId": showId,
        "bidAmount": bidAmount,
        "bidRangeMin": bidRangeMin,
        "bidRangeMax": bidRangeMax,
        "interval": interval,
        "bidsPlacedCount": bidsPlacedCount,
      };
}
