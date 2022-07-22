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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(-10),
                child: Positioned(
                  top: 50,
                  child: Container(
                    child: Center(
                        child: AppText(
                      text: title[index],
                      size: 20,
                    )),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 228, 182),
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
              backgroundColor: Color.fromARGB(255, 255, 228, 182),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/CategoryPageImg/img5.gif",
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
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
