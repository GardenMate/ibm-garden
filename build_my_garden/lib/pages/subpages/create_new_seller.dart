import 'dart:io';
import 'package:build_my_garden/pages/subpages/add_location_page.dart';
import 'package:build_my_garden/service/seller_info_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();

class addSellerPage extends StatefulWidget {
  const addSellerPage({Key? key}) : super(key: key);

  @override
  State<addSellerPage> createState() => _addSellerPageState();
}

class _addSellerPageState extends State<addSellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SellerForm(),
      ),
    );
  }
}

class SellerForm extends StatefulWidget {
  const SellerForm({Key? key}) : super(key: key);

  @override
  State<SellerForm> createState() => _SellerFormState();
}

class _SellerFormState extends State<SellerForm> {
  SellerInfoService sellerInfoService = SellerInfoService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Color(0x0000),
          width: displayWidth(context),
          margin: EdgeInsets.only(
              left: displayWidth(context) * 0.07,
              right: displayWidth(context) * 0.07,
              top: displayHeight(context) * 0.05,
              bottom: displayHeight(context) * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: AppLargeText(text: "Let's Get Started!")),
              SizedBox(height: 20),
              AppLargeText(
                text: "First Name",
                size: 18,
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    fillColor: Color.fromARGB(20, 64, 42, 42),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 10,
              ),
              AppLargeText(
                text: "Last Name",
                size: 18,
              ),
              SizedBox(height: 5),
              SizedBox(
                height: 50,
                width: 200,
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    fillColor: Color.fromARGB(20, 64, 42, 42),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              AppLargeText(
                text: "Profile Picture",
                size: 18,
              ),
              SizedBox(height: 5),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(20, 64, 42, 42),
                ),
                child: Center(
                    child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 200,
                    width: 200,
                    child: GestureDetector(
                        onTap: () {
                          sellerInfoService
                              .getProfileImage()
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 200,
                          width: 200,
                          child: sellerInfoService.profileImage == null
                              ? Center(
                                  child: AppText(text: 'No image selected'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(sellerInfoService.profileImage!.path)
                                        .absolute,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )),
                  ),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              AppLargeText(
                text: "Dashboard Picture",
                size: 18,
              ),
              SizedBox(height: 5),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(20, 64, 42, 42),
                ),
                child: Center(
                    child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 200,
                    width: 200,
                    child: GestureDetector(
                        onTap: () {
                          sellerInfoService
                              .getDashboardImage()
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 200,
                          width: 200,
                          child: sellerInfoService.dashboardImage == null
                              ? Center(
                                  child: AppText(text: 'No image selected'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(sellerInfoService.dashboardImage!.path)
                                        .absolute,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )),
                  ),
                )),
              ),
              SizedBox(height: 10),
              Container(
                child: ResponsiveButton(
                  onPress: () async {
                    var response = await sellerInfoService
                        .postSeller(
                            _firstNameController.text, _lastNameController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddLocation()));
                      // Navigator.pop(context, true);
                      // setState(() {});
                    });
                  },
                  // [To Do] add error handling
                  text: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The dialog box
// void addSellerDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         SellerInfoService sellerInfoService = SellerInfoService();
//         return Dialog(
//             backgroundColor: Color.fromARGB(255, 255, 228, 182),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             elevation: 16,
//             child: Container());
//       });
// }
