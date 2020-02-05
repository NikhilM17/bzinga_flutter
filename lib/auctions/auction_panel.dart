import 'package:bzinga/auctions/auctions_list.dart';
import 'package:bzinga/auctions/auctions_list_view.dart';
import 'package:bzinga/auctions/model/auctions.dart';
import 'package:bzinga/auctions/tabs/range_bid.dart';
import 'package:bzinga/auctions/tabs/single_bid.dart';
import 'package:bzinga/auctions/view_models/auctions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AuctionsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AuctionsViewModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<Auction>>(
            future: model.auctions,
            builder: (_, AsyncSnapshot<List<Auction>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(child: const CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data != null) {
                    return AuctionsListView(
                        auctions: snapshot.data,
                        currentTab: 0,
                        firstScreen: FirstScreen(),
                        secondScreen: SecondScreen());
                  } else
                    return getTextView("No Data");
              }
            });
      },
    );
  }
}
