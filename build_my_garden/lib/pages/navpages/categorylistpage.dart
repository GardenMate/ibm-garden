import 'dart:ffi';
import 'package:build_my_garden/pages/navpages/DetailsPage.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 30),
              child: AppLargeText(
                text: "Categories",
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
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
                                    '.gif',
                                fit: BoxFit.cover,
                                width: displayWidth(context),
                              ),
                            )),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.8),
                                            Colors.transparent,
                                          ])),
                                )),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColorsList[index],
                                      // borderRadius: BorderRadius.only(
                                      // bottomLeft: Radius.circular(20),
                                      // bottomRight: Radius.circular(20),
                                      // ),
                                      // the color on top of the boxes
                                    ))),
                            Positioned(
                                child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            categories[index].name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                            Positioned(
                              height: 150,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsPage(),
                                  ));
                                },
                                child: Row(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}
