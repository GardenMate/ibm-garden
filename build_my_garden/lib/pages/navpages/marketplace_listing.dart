import 'dart:convert';

import 'package:build_my_garden/pages/service/listing_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class MarketPlaceHome extends StatefulWidget {
  const MarketPlaceHome({Key? key}) : super(key: key);

  @override
  State<MarketPlaceHome> createState() => _MarketPlaceHomeState();
}

class _MarketPlaceHomeState extends State<MarketPlaceHome> {
  ListingService listingService = ListingService();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Container(
          margin: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: Column(
            children: [
              AppLargeText(text: "Search Bar"),
              AppLargeText(text: "Nav Bar"),
              const SizedBox(height: 10),
              Row(
                children: const [
                  SizedBox(width: 80),
                  AppText(text: "New"),
                  SizedBox(width: 30),
                  AppText(text: "Near Me"),
                  SizedBox(width: 30),
                  AppText(text: "Category")
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  AppText(text: "Within 5 miles.."),
                  SizedBox(width: 20),
                  AppText(text: "Within 10 miles...")
                ],
              ),
              SizedBox(height: 10),
              FutureBuilder<ListOfListing>(
                  future: listingService.getListing(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Listing> listings = snapshot.data!.listings;
                      return Container(
                        height: 450,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: listings.length, // Number of listing
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 150,
                                color: const Color.fromARGB(0, 0, 0, 0),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Container(
                                        width: 150,
                                        child: Image.network(
                                            "http://10.0.2.2:8000/media/${listings[index].image}"),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          AppText(text: listings[index].title),
                                          SizedBox(height: 2),
                                          AppText(
                                              text: listings[index].plant_type,
                                              size: 12),
                                          SizedBox(height: 2),
                                          AppText(
                                            text:
                                                "${listings[index].price} ${listings[index].price_currency}",
                                            size: 22,
                                          ),
                                          SizedBox(height: 1),
                                          AppText(
                                            text:
                                                "${listings[index].quantity} ${listings[index].quantity_type}",
                                            size: 14,
                                          ),
                                          SizedBox(height: 5),
                                          AppText(
                                            text: listings[index].address,
                                            size: 12,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ));
  }
}
