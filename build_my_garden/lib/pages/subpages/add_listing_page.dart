import 'dart:io';

import 'package:build_my_garden/service/add_image_service.dart';
import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/service/planttype_service.dart';
import 'package:build_my_garden/service/seller_info_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:build_my_garden/pages/subpages/add_plant_type_page.dart';
import 'package:build_my_garden/service/address_service.dart';

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
  SellerInfoService sellerInfoService = SellerInfoService();
  AddressService addressService = AddressService();
  // ListOfAddress listOfAddress = ListOfAddress(addresses: addressService.getAddress());

  // List<String> streetAddress = [];
  List<String> units = ["Item", "lbs", "oz", "kg", "g", "ml"];
  String? seletectUnit = "Item";
  late List<PlantType> plantTypes;
  late int plant_index;
  // Address? dummy_address;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                      child: GestureDetector(
                        onTap: () async {
                          final plant_index_list = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlantTypePage(),
                            ),
                          );
                          print(plant_index_list);
                          setState(() {
                            print(_titleController.text);
                            //To do : make sure it doesn't crash when the users dont select a plant type
                            _typeController.text = plant_index_list[0];
                            print(_typeController.text);
                            plant_index = plant_index_list[1];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            //     borderSide: const BorderSide(
                            //         width: 0, style: BorderStyle.none),
                            // fillColor: Colors.white,
                            // filled: true,
                          ),
                          child: AppText(
                            text: _typeController.text,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 10,),
                    // ResponsiveButton(onPress: () => {Navigator.push(context, MaterialPageRoute(builder: (context)=> PlantTypePage() ))}, text: "Add Plant type", width: 120, size: 12,),
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
                      // child: TextField(
                      //   controller: _unitController,
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         borderSide: const BorderSide(
                      //             width: 0, style: BorderStyle.none)),
                      //     fillColor: Colors.white,
                      //     filled: true,
                      //   ),
                      // ),
                      child: DropdownButton<String>(
                        value: seletectUnit,
                        items: units.map((item) {
                          return DropdownMenuItem<String>(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (item) {
                          setState(() {
                            seletectUnit = item;
                            _unitController.text = item!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            AppText(text: "Location"),
            FutureBuilder<ListOfAddress>(
              future: addressService.getAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Address> addresses = snapshot.data!.addresses;
                  // return ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemCount: addresses.length,
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       child: AppText(text: addresses[index].street_address.toString())
                  //     );
                  //   },
                  // );
                  return DropdownButton<Address>(
                    value: addresses[0],
                    items: addresses.map((item) {
                      return DropdownMenuItem<Address>(
                        child: Text(item.street_address.toString()),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() {
                        _locationController.text = item!.id.toString();
                        // dummy_address = item!;
                      });
                    },
                  );
                }
                return AppText(text: "No Address");
              },
            ),
            SizedBox(
              height: 30,
              // child: TextField(
              //   controller: _locationController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15.0),
              //         borderSide:
              //             BorderSide(width: 0, style: BorderStyle.none)),
              //     fillColor: Colors.white,
              //     filled: true,
              //   ),
              // ),
              // child: DropdownButton<String>(
              //   value: selectLocation,
              //   items: .map((item) {
              //     return DropdownMenuItem<String>(
              //       child: Text(item),
              //       value: item,
              //     );
              //   }).toList(),
              //   onChanged: (item) {
              //     setState(() {
              //       selectLocation = item;
              //       _locationController.text = item!;
              //     });
              //   },
              // ),
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
