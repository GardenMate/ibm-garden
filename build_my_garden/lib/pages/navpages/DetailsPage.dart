import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  int index;
  DetailsPage({Key? key, required this.index}) : super(key: key);
  List title = [
    "Sustainable Farming Practices",
    "Homemade Compost from your Kitchen",
    "Planting and monitoring your produce",
    "Save your Soil"
  ];
  List info = ["Alec", "prana", "Deepak", "Manu"];
  List images = [
    "assets/images/CategoryPageImg/img1.gif",
    "assets/images/CategoryPageImg/img2.gif",
    "assets/images/CategoryPageImg/img3.gif",
    "assets/images/CategoryPageImg/img4.gif"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: []),

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(-10),
                child: Positioned(
                  top: 50,
                  child: Container(
                    child: Center(
                        child: AppText(
                      text: title[index],
                      size: 20,
                      color: Color.fromARGB(255, 255, 255, 255),

                    )),

                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 78, 83),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 10),
                          topRight: Radius.elliptical(20, 10),
                          bottomLeft: Radius.elliptical(5, 0),
                          bottomRight: Radius.elliptical(5, 0),
                        )),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: Color.fromARGB(255, 8, 78, 83),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(images[index],
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    height: double.infinity),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
                    child: Column(
              children: [
                Container(
                  child: Center(
                    child:
                        AppText(fontWeight: FontWeight.w300, text: info[index]),
                  ),
                  margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                )
              ],
            )))
          ],
        ));
  }
}
