class AuctionResponse {
  int status;
  Data data;

  AuctionResponse({this.status, this.data});

  factory AuctionResponse.fromJson(Map<String, dynamic> json) =>
      new AuctionResponse(
          status: json['status'], data: Data.fromJson(json['data']));
}

class Auction {
  String id;
  String auctionStartTime;
  String auctionEndTime;
  Product product;

  Auction({this.id, this.auctionStartTime, this.auctionEndTime, this.product});

  factory Auction.fromJson(Map<String, dynamic> json) => new Auction(
      id: json['id'],
      auctionStartTime: json['auctionStartTime'],
      auctionEndTime: json['auctionEndTime'],
      product: Product.fromJson(json['product']));
}

class Product {
  String id;
  String productName;
  String productDescription;
  String productImage;

  Product(
      {this.id, this.productName, this.productDescription, this.productImage});

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
      id: json['id'],
      productName: json['productName'],
      productDescription: json['description'],
      productImage: json['productImage']);
}

class Data {
  List<Auction> auctions;

  Data({this.auctions});

  factory Data.fromJson(Map<String, dynamic> resMap) => new Data(
        auctions: (resMap['auctions'] as List)
            .map((model) => Auction.fromJson(model))
            .toList(),
      );
}
