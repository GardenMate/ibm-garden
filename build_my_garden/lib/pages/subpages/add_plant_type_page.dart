import 'package:build_my_garden/pages/subpages/add_listing_page.dart';
import 'package:build_my_garden/pages/subpages/get_location.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:build_my_garden/service/planttype_service.dart';
import 'package:build_my_garden/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';

class PlantTypePage extends StatefulWidget {
  const PlantTypePage({Key? key}) : super(key: key);

  @override
  State<PlantTypePage> createState() => _PlantTypePageState();
}

class _PlantTypePageState extends State<PlantTypePage> {
  PlantTypeService plantTypeService = PlantTypeService();
  bool _searched = false;
  String _searchResult = "";
  TextEditingController _searchController = TextEditingController();
  String _plantName = "";
  int _index = 0;

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
              SizedBox(height: 10),
              FutureBuilder<ListOfPlantTypes>(
                future: plantTypeService.getPlantType(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && _searched == false) {
                    List<PlantType> plantTypes = snapshot.data!.plantTypes;
                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: plantTypes.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: displayWidth(context) * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: ElevatedButton(
                                      child: AppText(
                                        text: plantTypes[index].plant_name,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onPressed: () {
                                        _plantName =
                                            plantTypes[index].plant_name;
                                        Navigator.pop(
                                          context,
                                          [
                                            plantTypes[index].plant_name,
                                            plantTypes[index].id
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (_searched == true) {
                    return FutureBuilder<ListOfPlantTypes>(
                        future:
                            plantTypeService.getSearchPlantTypes(_searchResult),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<PlantType> plantTypes =
                                snapshot.data!.plantTypes;
                            return Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: plantTypes.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: displayWidth(context) * 0.9,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30.0),
                                            child: ElevatedButton(
                                              child: AppText(
                                                text: plantTypes[index]
                                                    .plant_name,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, [
                                                  plantTypes[index].plant_name,
                                                  plantTypes[index].id
                                                ]);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  }

                  return Center(child: Text("No Plant Types Found"));
                },
              ),
            ],
          ),
        ));
  }
}
