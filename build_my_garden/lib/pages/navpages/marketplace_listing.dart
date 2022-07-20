import 'dart:convert';

import 'package:build_my_garden/pages/subpages/detail_listing_page.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class MarketPlaceHome extends StatefulWidget {
  const MarketPlaceHome({Key? key}) : super(key: key);

  @override
  State<MarketPlaceHome> createState() => _MarketPlaceHomeState();
}

class _MarketPlaceHomeState extends State<MarketPlaceHome> {
  ListingService listingService = ListingService();
  bool _searched = false;
  String _searchResult = "";
  TextEditingController _searchController = TextEditingController();

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
              Container(
                  width: displayWidth(context) * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: SearchBar(
                    searchController: _searchController,
                    onSubmit: (search) {
                      _searchResult = search;
                      _searched = true;
                      setState(() {});
                    },
                    onXMarkPress: () {
                      _searchResult = "";
                      _searched = false;
                      _searchController.clear();
                      setState(() {});
                    },
                  )),
              const SizedBox(height: 10),
              Row(
                children: const [
                  SizedBox(width: 80),
                  AppText(
                    text: "New",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 80, 18),
                    size: 20,
                  ),
                  SizedBox(width: 30),
                  AppText(
                    text: "Near Me",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 80, 18),
                    size: 20,
                  ),
                  SizedBox(width: 30),
                  AppText(
                    text: "Category",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 80, 18),
                    size: 20,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  AppText(
                    text: "Within 5 miles..",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 80, 18),
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  AppText(
                    text: "Within 10 miles...",
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 36, 80, 18),
                    size: 20,
                  )
                ],
              ),
              SizedBox(height: 10),
              FutureBuilder<ListOfListing>(
                  future: listingService.getListing(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && _searched == false) {
                      List<Listing> listings = snapshot.data!.listings;
                      return Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: listings.length, // Number of listing
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailListing(
                                                listingId: listings[index].id,
                                              )));
                                },
                                child: Container(
                                  height: 150,
                                  color: const Color.fromARGB(0, 0, 0, 0),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                        SizedBox(width: 5),
                                        Container(
                                          height: 150,
                                          width: 150,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "http://10.0.2.2:8000/media/${listings[index].image}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            AppText(
                                                text: listings[index].title),
                                            const SizedBox(height: 2),
                                            // AppText(
                                            //     text: listings[index].plant_type,
                                            //     size: 12),
                                            RatingBarIndicator(
                                              rating:
                                                  listings[index].seller_rating,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15.0,
                                              direction: Axis.horizontal,
                                            ),
                                            const SizedBox(height: 2),
                                            AppText(
                                              // Transform USD to symbols
                                              text:
                                                  "\$ ${listings[index].price}", // ${listings[index].price_currency}",
                                              size: 20,
                                              color: const Color.fromARGB(
                                                  255, 59, 164, 17),
                                            ),
                                            SizedBox(height: 1),
                                            AppText(
                                              text:
                                                  "${listings[index].quantity} ${listings[index].quantity_type}",
                                              size: 14,
                                              color: const Color.fromARGB(
                                                  255, 59, 87, 48),
                                            ),
                                            const SizedBox(height: 5),
                                            AppText(
                                              text: listings[index].address,
                                              size: 12,
                                              color: const Color.fromARGB(
                                                  255, 59, 87, 48),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (_searched == true) {
                      return FutureBuilder<ListOfListing>(
                          future:
                              listingService.getSearchListing(_searchResult),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Listing> listings = snapshot.data!.listings;
                              return Expanded(
                                child: Column(
                                  children: [
                                    AppText(
                                        text: "You searched: $_searchResult"),
                                    Expanded(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: listings
                                              .length, // Number of listing
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailListing(
                                                              listingId:
                                                                  listings[
                                                                          index]
                                                                      .id,
                                                            )));
                                              },
                                              child: Container(
                                                height: 150,
                                                color: const Color.fromARGB(
                                                    0, 0, 0, 0),
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: Offset(0, 0),
                                                        )
                                                      ]),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 5),
                                                      Container(
                                                        height: 150,
                                                        width: 150,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.network(
                                                            "http://10.0.2.2:8000/media/${listings[index].image}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          AppText(
                                                              text: listings[
                                                                      index]
                                                                  .title),
                                                          const SizedBox(
                                                              height: 2),
                                                          // AppText(
                                                          //     text: listings[index].plant_type,
                                                          //     size: 12),
                                                          RatingBarIndicator(
                                                            rating: listings[
                                                                    index]
                                                                .seller_rating,
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15.0,
                                                            direction:
                                                                Axis.horizontal,
                                                          ),
                                                          const SizedBox(
                                                              height: 2),
                                                          AppText(
                                                            // Transform USD to symbols
                                                            text:
                                                                "\$ ${listings[index].price}", // ${listings[index].price_currency}",
                                                            size: 20,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                59,
                                                                164,
                                                                17),
                                                          ),
                                                          SizedBox(height: 1),
                                                          AppText(
                                                            text:
                                                                "${listings[index].quantity} ${listings[index].quantity_type}",
                                                            size: 14,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                59,
                                                                87,
                                                                48),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          AppText(
                                                            text:
                                                                listings[index]
                                                                    .address,
                                                            size: 12,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                59,
                                                                87,
                                                                48),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ));
  }
}
