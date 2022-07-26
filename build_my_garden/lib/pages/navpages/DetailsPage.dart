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
  List info = [
    "An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. \nSuch a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests. \nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. \nSuch a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.",
    "An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests. \nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. \nSuch a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.",
    "An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.",
    "An economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests.\nAn economically and socially sustainable agriculture system is one that enables farms of all sizes to be profitable and contribute to their local economies. Such a system supports the next generation of farmers, deals fairly with its workers, promotes racial equity and justice, creates access to healthy food for all, and prioritizes people and communities over corporate interests."
  ];
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
              toolbarHeight: 90,
              automaticallyImplyLeading: false,
              title: Row(children: [
                Container(
                  margin: EdgeInsets.only(top: 38, left: 6.4, bottom: 17),
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
                )
              ]),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
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
                    height: double.maxFinite),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    child: Center(
                      child: AppText(
                          fontWeight: FontWeight.w300, text: info[index]),
                    ),
                    margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                  ),
                ],
              )),
            ),
          ],
        ));
  }
}
