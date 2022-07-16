import 'package:build_my_garden/main.dart';
import 'package:build_my_garden/pages/navpages/account_page.dart';
import 'package:build_my_garden/pages/navpages/marketplace_listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailListing extends StatefulWidget {
  int beforeIndex;

  DetailListing({Key? key, this.beforeIndex = 2}) : super(key: key);

  @override
  State<DetailListing> createState() => _DetailListingState();
}

class _DetailListingState extends State<DetailListing> {
  late int currentIndex;
  final screens = [
    CenterWithButton(text: "Learn"),
    CenterWithButton(text: "Your Plants"),
    MarketPlaceHome(),
    AccountPage(),
  ];

  @override
  void initState() {
    currentIndex = widget.beforeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.black,
      ),
    );
  }
}
