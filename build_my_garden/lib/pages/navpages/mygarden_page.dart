import 'package:build_my_garden/pages/subpages/add_plants_page.dart';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:build_my_garden/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/pages/subpages/add_plants_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyGardenPage extends StatefulWidget {
  const MyGardenPage({Key? key}) : super(key: key);

  @override
  State<MyGardenPage> createState() => _MyGardenPageState();
}

class _MyGardenPageState extends State<MyGardenPage> {
  PlantService plantService = PlantService();
  late List<Plant> plants;
  TextEditingController _searchController = TextEditingController();
  bool _searched = false;
  String _search = "";

  var months = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'Jul',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: displayHeight(context),
      width: displayWidth(context),
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Container(
                  width: displayWidth(context) * 0.8,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: SearchBar(
                      searchController: _searchController,
                      onSubmit: (search) {
                        _search = search;
                        _searched = true;
                        setState(() {});
                      },
                      onXMarkPress: () {
                        _search = "";
                        _searched = false;
                        _searchController.clear();
                        setState(() {});
                      }),
                )),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: AppLargeText(
                  text: "My Garden Status",
                  size: 18,
                ),
              ),
            ),
            //Add a new plus icon button to the top right of the page
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ResponsiveButton(
                  onPress: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlantForm()));
                    setState(() {});
                  },
                  text: "+",
                  width: 50,
                  size: 20,
                ),
              ),
            ),
            FutureBuilder<ListOfPlants>(
              future: plantService.getPlant(),
              builder: (context, snapshot) {
                // Get the time when the mygarden is loaded
                DateTime now = DateTime.now();

                if (snapshot.hasData && _searched == false) {
                  List<Plant> plants = snapshot.data!.plants;
                  return Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: plants.length,
                    itemBuilder: (context, index) {
                      var harvestLength;
                      var date =
                          DateTime.parse(plants[index].planted_date.toString());

                      // Change duration string into duration, [TODO]: Create a function
                      List<String> timePart =
                          plants[index].harvest_length.split(' ');
                      if (timePart.length > 1) {
                        harvestLength = Duration(days: int.parse(timePart[0]));
                      }
                      // var harvestLength = Duration(days: plants[index].harvest_length);
                      var harvestDate = date.add(harvestLength);

                      Duration timeLeft = harvestDate.difference(now);

                      if (int.parse(timeLeft.inDays.toString()) < 0) {
                        timeLeft = Duration(days: 0);
                      }

                      //making the date object
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: displayWidth(context),
                          child: Stack(children: [
                            Container(
                              height: 140,
                              width: displayWidth(context),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "$baseUrl${plants[index].image}"),
                                    )),
                              ),
                            ),
                            Positioned(
                                child: Container(
                              padding: const EdgeInsets.only(top: 1, bottom: 0),
                              height: 135,
                              width: displayWidth(context),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(79, 34, 35, 31),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                            )),
                            Positioned(
                              top: 75,
                              bottom: 20,
                              right: -20,
                              child: Container(
                                height: 400,
                                width: 180,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                child: Center(
                                  child: AppText(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    text:
                                        "Planted: ${months[date.month.toString()]} ${date.day} ${date.year}\nWater Need: Daily",
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 14,
                                  ),
                                ),
                              ),
                            ),

                            //Create a new positioned widget to display the learn more text widget on top right of the image
                            const Positioned(
                              right: 20,
                              child: AppLargeText(
                                text: "...",
                                color: Colors.white,
                              ),
                            ),
                            //Create a new positioned widget to display circle shape to the upper left of the image
                            Positioned(
                              top: 10,
                              left: 15,
                              child: Container(
                                child: CircularPercentIndicator(
                                  radius: 50,
                                  lineWidth: 12,
                                  startAngle: 180,
                                  backgroundColor: Colors.white,
                                  percent:
                                      double.parse(timeLeft.inDays.toString()) /
                                          double.parse(
                                              harvestLength.inDays.toString()),
                                  progressColor:
                                      Color.fromARGB(255, 255, 217, 0),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  header: Container(
                                    child: const AppText(
                                      text: "Status",
                                      size: 12,
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  center: Container(
                                    height: 77,
                                    width: 77,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Create a new positioned widget to display text in the center of the circle shape
                            Positioned(
                                top: 45,
                                left: 40,
                                child: Column(
                                  children: [
                                    AppText(
                                      text: timeLeft.inDays.toString(),
                                      size: 20,
                                      color: Color.fromARGB(249, 0, 0, 0),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    //Create a text widget that is centered and under the previous text widget
                                    const AppText(
                                      text: "Until",
                                      size: 12,
                                      color: Color.fromARGB(249, 0, 0, 0),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    //Create a text widget that is centered and under the previous text widget
                                    const AppText(
                                      text: "Harvest",
                                      size: 12,
                                      color: Color.fromARGB(249, 0, 0, 0),
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                )),
                          ]),
                        ),
                      );
                    },
                  ));
                } else if (_searched == true) {
                  return FutureBuilder<ListOfPlants>(
                      future: plantService.getSearchPlant(_search),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Plant> plants = snapshot.data!.plants;
                          return Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: AppText(
                                      text: "You searched: $_search",
                                      size: 20)),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: plants.length,
                                  itemBuilder: (context, index) {
                                    var harvestLength;
                                    var date = DateTime.parse(
                                        plants[index].planted_date.toString());

                                    // Change duration string into duration, [TODO]: Create a function
                                    List<String> timePart =
                                        plants[index].harvest_length.split(' ');
                                    if (timePart.length > 1) {
                                      harvestLength = Duration(
                                          days: int.parse(timePart[0]));
                                    }
                                    // var harvestLength = Duration(days: plants[index].harvest_length);
                                    var harvestDate = date.add(harvestLength);

                                    Duration timeLeft =
                                        harvestDate.difference(now);

                                    if (int.parse(timeLeft.inDays.toString()) <
                                        0) {
                                      timeLeft = Duration(days: 0);
                                    }

                                    //making the date object
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        width: displayWidth(context),
                                        child: Stack(children: [
                                          Container(
                                            height: 140,
                                            width: displayWidth(context),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(25)),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "$baseUrl${plants[index].image}"),
                                                  )),
                                            ),
                                          ),
                                          Positioned(
                                              child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 1, bottom: 0),
                                            height: 135,
                                            width: displayWidth(context),
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    79, 34, 35, 31),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25))),
                                          )),
                                          Positioned(
                                            top: 75,
                                            bottom: 20,
                                            right: -20,
                                            child: Container(
                                              height: 400,
                                              width: 180,
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25))),
                                              child: Center(
                                                child: AppText(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  text:
                                                      "Planted: ${months[date.month.toString()]} ${date.day} ${date.year}\nWater Need: Daily",
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //Create a new positioned widget to display the learn more text widget on top right of the image
                                          const Positioned(
                                            right: 20,
                                            child: AppLargeText(
                                              text: "...",
                                              color: Colors.white,
                                            ),
                                          ),
                                          //Create a new positioned widget to display circle shape to the upper left of the image
                                          Positioned(
                                            top: 10,
                                            left: 15,
                                            child: Container(
                                              child: CircularPercentIndicator(
                                                radius: 50,
                                                lineWidth: 12,
                                                startAngle: 180,
                                                backgroundColor: Colors.white,
                                                percent: double.parse(timeLeft
                                                        .inDays
                                                        .toString()) /
                                                    double.parse(harvestLength
                                                        .inDays
                                                        .toString()),
                                                progressColor: Color.fromARGB(
                                                    255, 255, 217, 0),
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                animation: true,
                                                header: Container(
                                                  child: const AppText(
                                                    text: "Status",
                                                    size: 12,
                                                    color: Colors.white,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                center: Container(
                                                  height: 77,
                                                  width: 77,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //Create a new positioned widget to display text in the center of the circle shape
                                          Positioned(
                                              top: 45,
                                              left: 40,
                                              child: Column(
                                                children: [
                                                  AppText(
                                                    text: timeLeft.inDays
                                                        .toString(),
                                                    size: 20,
                                                    color: Color.fromARGB(
                                                        249, 0, 0, 0),
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  //Create a text widget that is centered and under the previous text widget
                                                  const AppText(
                                                    text: "Until",
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        249, 0, 0, 0),
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  //Create a text widget that is centered and under the previous text widget
                                                  const AppText(
                                                    text: "Harvest",
                                                    size: 12,
                                                    color: Color.fromARGB(
                                                        249, 0, 0, 0),
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ],
                                              )),
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ));
                        }
                        return Center(child: CircularProgressIndicator());
                      });
                }
                return const Center(child: const CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
