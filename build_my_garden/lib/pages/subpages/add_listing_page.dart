import 'dart:io';

import 'package:build_my_garden/service/add_image_service.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

TextEditingController _priceController = TextEditingController();
TextEditingController _titleController = TextEditingController();
TextEditingController _descController = TextEditingController();
TextEditingController _typeController = TextEditingController();
TextEditingController _qtyController = TextEditingController();
TextEditingController _unitController = TextEditingController();
TextEditingController _locationController = TextEditingController();
TextEditingController _distanceFromLocationController = TextEditingController();

void addListingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      ListingService listingService = ListingService();
      AddImageService addImageService = AddImageService();

      return Dialog(
        backgroundColor: Color.fromARGB(255, 255, 228, 182),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 16,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          reverse: true,
          padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom) *
              0.5,
          child: ListingForm(),
        ),
      );
    },
  );
}

class ListingForm extends StatefulWidget {
  const ListingForm({Key? key}) : super(key: key);

  @override
  State<ListingForm> createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  ListingService listingService = ListingService();
  AddImageService addImageService = AddImageService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      // padding: MediaQuery.of(context).viewInsets ,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: Container(
                  height: 200,
                  width: 200,

                  child: InkWell(
                    onTap: () {
                      addImageService.getImage().then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      child: addImageService.image == null
                          ? Center(child: Text('Pick Image'))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(addImageService.image!.path).absolute,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),

                  // Here
                ))),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Price"),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Willing to travel"),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: TextField(
                      controller: _distanceFromLocationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppText(text: "Product title"),
          SizedBox(
            height: 30,
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          AppText(text: "Description"),
          SizedBox(
            child: TextFormField(
              controller: _descController,
              maxLines: 7,
              autocorrect: true,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  AppText(text: "Type"),
                  SizedBox(
                    height: 30,
                    width: 100,
                    child: TextField(
                      controller: _typeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  AppText(text: "Qty"),
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _qtyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  AppText(text: "Unit"),
                  SizedBox(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _unitController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          AppText(text: "Location"),
          SizedBox(
            height: 30,
            child: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: displayWidth(context),
            child: Center(
              child: ResponsiveButton(
                onPress: () async {
                  AddListingResponse response =
                      await listingService.postListing(
                          _titleController.text,
                          _descController.text,
                          _priceController.text,
                          _typeController.text,
                          _qtyController.text,
                          _unitController.text,
                          _locationController.text,
                          _distanceFromLocationController.text);
                  // [To Do] Manage error, to not let it post if image isn't uploaded
                  print("---------------------TEST-----------");
                  print(response.id!);
                  if (response != null) {
                    print("----YES----");
                    var imageResponse = addImageService
                        .uploadImage((response.id).toString())
                        .then((value) => print('----MUST---'));
                    print("----ID----");
                    Navigator.pop(context, true);
                    _titleController.clear();
                    _descController.clear();
                    _priceController.clear();
                    _typeController.clear();
                    _qtyController.clear();
                    _unitController.clear();
                    _locationController.clear();
                    _distanceFromLocationController.clear();
                  }
                },
                text: "Add",
              ),
            ),
          )
        ],
      ),
    );
  }
}
