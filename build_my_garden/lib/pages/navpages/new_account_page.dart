import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:build_my_garden/pages/subpages/add_listing_page.dart';
import 'package:build_my_garden/pages/subpages/create_new_seller.dart';
import 'package:build_my_garden/pages/subpages/detail_listing_page.dart';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/service/seller_info_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:build_my_garden/pages/navpages/account_page.dart';
// ignore: depend_on_referenced_packages


class New_account_page extends StatelessWidget {
  const New_account_page({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   var seller;
   return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 5.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * .3,
              child: Row(
                children: [
                  AppText(
                    text: seller.first_name.isNotEmpty
                        ? "${seller.first_name} ${seller.last_name}"
                        : "${seller.username}",
                    fontWeight: FontWeight.w800,
                    size: 25,
                  ),
                  SizedBox(
                      height: 24,
                      child: Image.asset("assets/images/verified.png")),
                ],
              ),
            ),
            Text(
              'johndoe@gmail.com',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  
                 
                 
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}