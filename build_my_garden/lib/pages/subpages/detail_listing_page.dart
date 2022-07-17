import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailListing extends StatefulWidget {
  int listingId;

  DetailListing({Key? key, required this.listingId}) : super(key: key);

  @override
  State<DetailListing> createState() => _DetailListingState();
}

class _DetailListingState extends State<DetailListing> {
  ListingService listingService = ListingService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SingleListing>(
        future: listingService.getDetailListing(widget.listingId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SingleListing listing = snapshot.data!;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.green,
                    ),
                    height: 350,
                    child: AppText(text: "Images"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppLargeText(text: listing.title),
                        AppText(
                            color: const Color.fromARGB(255, 152, 167, 177),
                            text: listing.seller_first_name.isNotEmpty
                                ? "${listing.seller_first_name} ${listing.seller_first_name}"
                                : listing.seller_username),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBarIndicator(
                          rating: listing.seller_rating.toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: "\$${listing.price}",
                          size: 24,
                          color: const Color.fromARGB(255, 59, 164, 17),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(text: "${listing.description}"),
                        const SizedBox(
                          height: 50,
                        ),
                        AppText(
                            text: "Customer question & answer and other stuff"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
