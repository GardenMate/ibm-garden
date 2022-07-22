import 'dart:ffi';
import 'package:build_my_garden/pages/navpages/DetailsPage.dart';
import 'package:build_my_garden/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:build_my_garden/helpers/appcolors.dart';
import 'package:build_my_garden/helpers/utils.dart';
import 'package:build_my_garden/models/category.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../sizes_helpers.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Category> categories = Utils.getMockedCategories();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 35, left: 35, top: 30, bottom: 10),
            child: SearchBar(
                searchController: _searchController,
                onSubmit: (search) {},
                onXMarkPress: () {}),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 30),
              child: AppLargeText(
                text: "Categories",
              )),
          Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(index: index),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 10, bottom: 20, right: 10, top: 10),
                          height: 150,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned.fill(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/CategoryPageImg/' +
                                      categories[index].imgName +
                                      '.png',
                                  fit: BoxFit.cover,
                                  width: displayWidth(context),
                                ),
                              )),
                              Positioned(
                                  // bottom: 0,
                                  // right: 0,
                                  // left: 0,
                                  child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.bottomCenter,
                                  //     end: Alignment.topCenter,
                                  //     colors: [
                                  //       Colors.black.withOpacity(0.8),
                                  //       Colors.transparent,
                                  //     ]
                                  //     )
                                ),
                              )),
                              // Positioned(
                              //     bottom: 0,
                              //     right: 0,
                              //     left: 0,
                              //     child: Container(
                              //         height: 150,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(20),
                              //           color: AppColorsList[index],
                              //           // borderRadius: BorderRadius.only(
                              //           // bottomLeft: Radius.circular(20),
                              //           // bottomRight: Radius.circular(20),
                              //           // ),
                              //           // the color on top of the boxes
                              //         ))),
                              Positioned(
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              categories[index].name,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 8, 78, 83),
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                              // Positioned(
                              //   height: 150,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       Navigator.of(context).push(MaterialPageRoute(
                              //         builder: (context) => DetailsPage(),
                              //       )
                              //       );
                              //     },
                              //     child: Row(),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}
