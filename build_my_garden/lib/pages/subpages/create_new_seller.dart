import 'dart:io';
import 'package:build_my_garden/service/seller_info_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

TextEditingController _firstNameController = TextEditingController();
TextEditingController _lastNameController = TextEditingController();

void addSellerDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        SellerInfoService sellerInfoService = SellerInfoService();
        return Dialog(
          backgroundColor: Color.fromARGB(255, 255, 228, 182),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom) *
                0.5,
            child: SellerForm(),
          ),
        );
      });
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
      width: displayWidth(context),
      margin: EdgeInsets.only(
          left: displayWidth(context) * 0.05,
          right: displayWidth(context) * 0.05,
          top: displayHeight(context) * 0.05,
          bottom: displayHeight(context) * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "First Name",
          ),
          SizedBox(
            height: 30,
            width: 200,
            child: TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            height: 10,
          ),
          AppText(
            text: "Last Name",
          ),
          SizedBox(
            height: 30,
            width: 200,
            child: TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            height: 10,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
                child: Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: 200,
                      width: 200,
                      child: sellerInfoService.profileImage == null
                          ? Center(child: Text('No image selected'))
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
            width: 200,
            height: 10,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Center(
                child: Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
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
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: 200,
                      width: 200,
                      child: sellerInfoService.dashboardImage == null
                          ? Center(child: Text('No image selected'))
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
          SizedBox(
            width: 200,
            height: 10,
          ),
          ResponsiveButton(
            onPress: () async {
              var response = await sellerInfoService
                  .postSeller(
                      _firstNameController.text, _lastNameController.text)
                  .then((value) {
                Navigator.pop(context, true);
                setState(() {});
              });
            },
            // [To Do] add error handling
            text: "Create User",
          ),
        ],
      ),
    );
  }
}
