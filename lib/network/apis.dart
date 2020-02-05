import 'package:bzinga/auctions/model/auctions.dart';

abstract class AuctionsApi {
  Future<List<Auction>> getAuctionsList();
}
