import 'dart:io';
import 'package:build_my_garden/pages/subpages/add_plant_type_page.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

TextEditingController _plantTypeController = TextEditingController();
TextEditingController _soilTypeController = TextEditingController();
TextEditingController _plantCurrentSizeHeight = TextEditingController();
TextEditingController _plantCurrentSizeWidth = TextEditingController();
TextEditingController _plantDated = TextEditingController();

// void addPlantDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         PlantService plantService = PlantService();

//         return Dialog(
//           backgroundColor: Color.fromARGB(255, 255, 228, 182),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           elevation: 16,
//           child: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             reverse: true,
//             padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom) *
//                 0.5,
//             child: PlantForm(),
//           ),
//         );
//       });
// }

class PlantForm extends StatefulWidget {
  const PlantForm({Key? key}) : super(key: key);

  @override
  State<PlantForm> createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  PlantService plantService = PlantService();
  late DateTime now = new DateTime.now();
  late DateTime _date = new DateTime(now.year, now.month, now.day);
  int? plant_index;

  @override
  void initState() {
    // TODO: implement initState
    _date = DateTime(now.year, now.month, now.day);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: displayWidth(context),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 167, 158, 158),
                ),
                child: Center(
                    child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 16, 15, 15),
                    ),
                    height: 200,
                    width: 200,
                    child: GestureDetector(
                        onTap: () {
                          plantService
                              .getImage()
                              .then((value) => setState(() {}));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 229, 222, 222),
                          ),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: plantService.image == null
                              ? Center(child: Text('No image selected'))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(plantService.image!.path).absolute,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )),
                  ),
                )),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 100,
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: AppText(
                      text: "Plant Type",
                      color: Color.fromARGB(255, 37, 36, 36),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      controller: _plantTypeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromARGB(20, 64, 42, 42),
                        filled: true,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 100,
                    height: 10,
                  ),
                  Center(
                    child: AppText(
                      text: "Soil Type",
                      color: Color.fromARGB(255, 59, 56, 56),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      controller: _soilTypeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromARGB(20, 64, 42, 42),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: AppText(
                      text: "Plant's Current Height",
                      color: Color.fromARGB(255, 44, 42, 42),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      controller: _plantCurrentSizeHeight,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromARGB(20, 64, 42, 42),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 10,
                  ),
                  Center(
                    child: AppText(
                      text: "Plant's Current Width",
                      color: Color.fromARGB(255, 46, 43, 43),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 200,
                    child: TextField(
                      controller: _plantCurrentSizeWidth,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Color.fromARGB(20, 64, 42, 42),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              SizedBox(
                width: 100,
                height: 10,

            ),
            

            
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  ResponsiveButton(
                    text: "Pick a date",
                    onPress: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then((date) => setState(() {
                            _date = date!;
                            _plantDated.text = _date.toString();
                          }));
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AppText(text: "Plant's Date:"),
                  SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: _date == Null
                        ? "No date selected"
                        : "${_date.year}/${_date.month}/${_date.day}",
                    color: Color.fromARGB(255, 56, 53, 53),
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: 20,
                    height: 10,
                  ),
                  Container(
                    width: displayWidth(context),
                    child: Center(
                      child: ResponsiveButton(
                        onPress: () async {
                          var response = await plantService
                              .uploadPlant(
                                  _plantTypeController.text,
                                  _soilTypeController.text,
                                  _plantCurrentSizeHeight.text,
                                  _plantCurrentSizeWidth.text,
                                  _plantDated.text.split(' ')[0])
                              .then((value) {
                            Navigator.pop(context, true);
                            setState(() {});
                          });
                        },
                        // [To Do] add error handling
                        text: "Add Plant",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
