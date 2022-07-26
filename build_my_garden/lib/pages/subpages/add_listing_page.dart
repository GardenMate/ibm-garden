import 'dart:io';

import 'package:build_my_garden/service/add_image_service.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/service/planttype_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:build_my_garden/pages/subpages/add_plant_type_page.dart';

TextEditingController _priceController = TextEditingController();
TextEditingController _titleController = TextEditingController();
TextEditingController _descController = TextEditingController();
TextEditingController _typeController = TextEditingController();
TextEditingController _qtyController = TextEditingController();
TextEditingController _unitController = TextEditingController();
TextEditingController _locationController = TextEditingController();
TextEditingController _distanceFromLocationController = TextEditingController();

class ListingForm extends StatefulWidget {
  const ListingForm({Key? key}) : super(key: key);

  @override
  State<ListingForm> createState() => _ListingFormState();
}

class _ListingFormState extends State<ListingForm> {
  PlantService plantService = PlantService();
  ListingService listingService = ListingService();
  AddImageService addImageService = AddImageService();
  PlantTypeService plantTypeService = PlantTypeService();
  late List<PlantType> plantTypes;
  late int plant_index;

  @override
  Widget build(BuildContext context) {
    var plantTypeList = plantTypeService.getPlantType();

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Center(child: AppLargeText(text: "Post your Listing"))),
            SizedBox(
              height: 200,
              width: 200,
              child: Container(
                  decoration: const BoxDecoration(
                    color: const Color.fromARGB(20, 64, 42, 42),
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
              children: <Widget>[
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
                          fillColor: const Color.fromARGB(20, 64, 42, 42),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: displayWidth(context) * 0.5 - 120),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Willing to travel (miles)"),
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
                          fillColor: const Color.fromARGB(20, 64, 42, 42),
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
                  fillColor: const Color.fromARGB(20, 64, 42, 42),
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
                  fillColor: const Color.fromARGB(20, 64, 42, 42),
                  filled: true,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Type"),
                SizedBox(
                  height: 30,
                  width: displayWidth(context),
                  child: GestureDetector(
                    onTap: () async {
                      final plant_index_list = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlantTypePage(),
                        ),
                      );
                      setState(() {
                        _typeController.text = plant_index_list[0];
                        plant_index = plant_index_list[1];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(20, 64, 42, 42),
                        borderRadius: BorderRadius.circular(10.0),
                        //     borderSide: const BorderSide(
                        //         width: 0, style: BorderStyle.none),
                        // fillColor: const Color.fromARGB(20, 64, 42, 42),
                        // filled: true,
                      ),
                      child: Center(
                        child: AppText(
                          text: _typeController.text,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                // ResponsiveButton(onPress: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=> PlantTypePage() ))}, text: "Add Plant type", width: 120, size: 12,),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Qty"),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: TextField(
                        controller: _qtyController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                          fillColor: const Color.fromARGB(20, 64, 42, 42),
                          filled: true,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(width: displayWidth(context) * 0.5 - 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Unit"),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: TextField(
                        controller: _unitController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                          fillColor: const Color.fromARGB(20, 64, 42, 42),
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
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  fillColor: const Color.fromARGB(20, 64, 42, 42),
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
                            plant_index.toString(),
                            _qtyController.text,
                            _unitController.text,
                            _locationController.text,
                            _distanceFromLocationController.text);
                    // [To Do] Manage error, to not let it post if image isn't uploaded

                    if (response != null) {
                      var imageResponse = addImageService
                          .uploadImage((response.id).toString())
                          .then((value) {
                        Navigator.pop(context, true);
                        _titleController.clear();
                        _descController.clear();
                        _priceController.clear();
                        _typeController.clear();
                        _qtyController.clear();
                        _unitController.clear();
                        _locationController.clear();
                        _distanceFromLocationController.clear();
                        setState(() {});
                      });
                    }
                  },
                  text: "Add",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
