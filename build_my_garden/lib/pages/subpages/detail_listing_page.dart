import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

import '../../service/braintree_service.dart';

class DetailListing extends StatefulWidget {
  int listingId;

  DetailListing({Key? key, required this.listingId}) : super(key: key);

  @override
  State<DetailListing> createState() => _DetailListingState();
}

class _DetailListingState extends State<DetailListing> {
  ListingService listingService = ListingService();
  BrainTreeService brainTreeService = BrainTreeService();
  int _currentImageIndex = 0;
  static final String? tokenizationKey = dotenv.env['BT_TOKENIZATION_KEY'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FutureBuilder<SingleListing>(
              future: listingService.getDetailListing(widget.listingId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SingleListing listing = snapshot.data!;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 350,
                              // [To Do] To improve the image functionality use https://pub.dev/packages/photo_view
                              child: PageView.builder(
                                  onPageChanged: (value) {
                                    setState(() {
                                      _currentImageIndex = value;
                                    });
                                  },
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: listing.image.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        color: Colors.green,
                                      ),
                                      height: 350,
                                      width: displayWidth(context),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        child: Image.network(
                                          "$baseUrl${listing.image[index]["image"]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            // Widget below are the dots to represent the image
                            Positioned(
                              top: 335,
                              left: displayWidth(context) * 0.5,
                              child: Row(
                                  children: List.generate(listing.image.length,
                                      (indexDot) {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: _currentImageIndex == indexDot
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                );
                              })),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppLargeText(text: listing.title),
                              AppText(
                                  color:
                                      const Color.fromARGB(255, 152, 167, 177),
                                  text: listing.seller_first_name.isNotEmpty
                                      ? "${listing.seller_first_name} ${listing.seller_first_name}"
                                      : listing.seller_username),
                              const SizedBox(
                                height: 10,
                              ),
                              RatingBarIndicator(
                                rating: listing.seller_rating,
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
                              const AppText(
                                  text:
                                      "Customer question & answer and other stuff"),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 50,
                          margin: EdgeInsets.only(top: 100),
                          child: Center(
                            child: ResponsiveButton(
                              buttonColor: Color.fromARGB(255, 8, 78, 83),
                              text: "Buy Now",
                              onPress: () async {
                                var request = BraintreeDropInRequest(
                                  tokenizationKey: tokenizationKey,
                                  collectDeviceData: true,
                                  googlePaymentRequest:
                                      BraintreeGooglePaymentRequest(
                                    totalPrice: listing.price.toString(),
                                    currencyCode: listing.price_currency,
                                    billingAddressRequired: false,
                                  ),
                                  paypalRequest: BraintreePayPalRequest(
                                    amount: listing.price.toString(),
                                    displayName: 'Example company',
                                  ),
                                  cardEnabled: true,
                                );
                                final result =
                                    await BraintreeDropIn.start(request);
                                if (result != null) {
                                  // Send a POST request to Django
                                  PaymentResponse response =
                                      await brainTreeService.postPayment(
                                          result.paymentMethodNonce.nonce,
                                          listing.price.toString(),
                                          listing.price_currency);
                                  showNonce(result.paymentMethodNonce, response,
                                      context);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          Container(
            margin: EdgeInsets.only(top: 31, left: 22),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 8, 78, 83),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
