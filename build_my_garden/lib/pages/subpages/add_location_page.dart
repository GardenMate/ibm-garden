import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

TextEditingController _addressController = TextEditingController();

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Center(child: AppLargeText(text: "Add your address!")),
          SizedBox(height: 20),
          AppLargeText(
            text: "Address",
            size: 18,
          ),
          SizedBox(height: 5),
          SizedBox(
            height: 50,
            width: 200,
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none)),
                fillColor: Color.fromARGB(20, 64, 42, 42),
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppLargeText(
            text: "Or",
            size: 18,
          ),
          SizedBox(height: 5),
          ResponsiveButton(
            onPress: () {},
            text: "Profile Picture",
          ),
          SizedBox(height: 5),
          Container(
            child: ResponsiveButton(
              onPress: () async {
                // var response = await sellerInfoService
                //     .postSeller(
                //         _firstNameController.text, _lastNameController.text)
                //     .then((value) {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => AddLocation()));
                //   // Navigator.pop(context, true);
                //   // setState(() {});
                // });
              },
              // [To Do] add error handling
              text: "Finish",
            ),
          ),
        ],
      ),
    );
  }
}
