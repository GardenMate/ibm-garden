import 'package:build_my_garden/pages/subpages/add_listing_page.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  ListingService listingService = ListingService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 180 + 60 + 5,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: Colors.black,
                  width: displayWidth(context),
                  height: 180,
                  child: Image(
                      image: AssetImage("assets/images/defaultBackground.png"),
                      fit: BoxFit.cover),
                ),
                Positioned(
                  top: 180 - 60,
                  left: displayWidth(context) / 2 - 60,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(7),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image(
                            image: AssetImage("assets/images/Profile-Icon.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          AppText(
            text: "Full Name or Username",
            fontWeight: FontWeight.w800,
            size: 25,
          ),
          AppText(text: "city"),
          RatingBarIndicator(
            rating: 4.5,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          SizedBox(height: 5),
          ResponsiveButton(
            onPress: () => {},
            text: "Message",
            buttonColor: Color.fromARGB(255, 156, 222, 155),
            textColor: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
            child: Row(
              children: [
                AppText(
                  text: "Listing",
                  fontWeight: FontWeight.w400,
                ),
                Spacer(),
                ResponsiveButton(
                  onPress: () => addListingDialog(context),
                  text: "+ Add",
                  buttonColor: Color.fromARGB(255, 156, 222, 155),
                )
              ],
            ),
          ),
          FutureBuilder<ListOfListing>(
              future: listingService.getSellersListing(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Listing> listings = snapshot.data!.listings;
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 10.0,
                        ),
                        padding: const EdgeInsets.all(8),
                        itemCount: listings.length, // Number of listing
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 200,
                            color: const Color.fromARGB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 160,
                                  width: 300,
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 160,
                                        width: 300,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "http://10.0.2.2:8000/media/${listings[index].image}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          height: 35,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Color.fromARGB(
                                                  255, 34, 49, 29)),
                                          child: Center(
                                            child: AppText(
                                              text:
                                                  "\$ ${listings[index].price}",
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 110,
                                        left: 110,
                                        child: Container(
                                          height: 35,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Color.fromARGB(
                                                  255, 34, 49, 29)),
                                          child: Center(
                                            child: AppText(
                                              text:
                                                  "${listings[index].quantity} ${listings[index].quantity_type}",
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AppText(text: listings[index].title),
                              ],
                            ),
                          );
                        }),
                  );
                }
                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }
}
