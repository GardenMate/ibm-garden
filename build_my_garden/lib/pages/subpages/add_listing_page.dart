import 'dart:io';
import 'dart:convert';

import 'package:build_my_garden/service/listing_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Center(
                          child: Container(
                        height: 200,
                        width: 200,
                        child: TextButton(
                          onPressed: () => {},
                          child: AddImage(),
                        ),
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
                                  borderSide: BorderSide(
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
                                  borderSide: BorderSide(
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
                              BorderSide(width: 0, style: BorderStyle.none)),
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
                              BorderSide(width: 0, style: BorderStyle.none)),
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
                                  borderSide: BorderSide(
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
                                  borderSide: BorderSide(
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
                                  borderSide: BorderSide(
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
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none)),
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
                      onPress: () => {
                        listingService.postListing(
                            _titleController.text,
                            _descController.text,
                            _priceController.text,
                            _typeController.text,
                            _qtyController.text,
                            _unitController.text,
                            _locationController.text,
                            _distanceFromLocationController.text)
                      },
                      text: "Add",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

// class AddImages {}

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  // late Future<File> file;
  // String status = "";
  // late String base64Image;
  // late File tempFile;
  // String error = "Error";

  // choseImage() {
  //   setState(() async {
  //     var filePath = await ImagePicker.pickImage(source: ImageSource.gallery);
  //     file = Future(File(filePath?.path));
  //   });
  //   setStatus('');
  // }

  // setStatus(String message) {
  //   setState(() {
  //     status = message;
  //   });
  // }

  // uploadImg() {
  //   if (tempFile == null) {
  //     setStatus(error);
  //     return;
  //   }

  //   String fileName = tempFile.path.split('/').last;
  //   // If name is needed need to store a string name on django
  //   upload(fileName);
  // }

  // upload(String fileName) async {
  //   // Store and reformate token correctly
  //   String? token = await SecureStorage.getToken();

  //   var response = await http
  //       .post(Uri.parse("http://10.0.2.2:8000/api/listing/"), headers: {
  //     'Authorization': 'Token $token',
  //   }, body: {
  //     "image": base64Image
  //   });
  //   return response;
  // }

// 2nd attempt
  // File? _image;
  // File? tempFile;
  // XFile? _pickedFile;
  // final _picker = ImagePicker();
  // String? base64Image;

  // // Implementing the image picker
  // Future<void> chooseImage() async {
  //   _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (_pickedFile != null) {
  //     setState(() {
  //       _image = File(_pickedFile!.path);
  //     });
  //   }
  // }

  // uploadImg() {
  //   if (tempFile == null) {
  //     return;
  //   }

  //   String? fileName = tempFile?.path.split('/').last;
  //   // If name is needed need to store a string name on django
  //   upload(fileName!);
  // }

  // upload(String fileName) async {
  //   // Store and reformate token correctly
  //   String? token = await SecureStorage.getToken();

  //   var response = await http
  //       .post(Uri.parse("http://10.0.2.2:8000/api/listing/"), headers: {
  //     'Authorization': 'Token $token',
  //   }, body: {
  //     "image": base64Image
  //   });
  //   return response;
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Column(
  //       children: [
  //         FutureBuilder<File>(
  //             builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done &&
  //               snapshot.data != null) {
  //             tempFile = snapshot.data;
  //             base64Image = base64Encode(snapshot.data!.readAsBytesSync());

  //             return Image.file(snapshot.data);
  //           } else if (snapshot.error != null) {
  //             return Text('Error');
  //           } else {
  //             return Container(
  //               child: Material(
  //                 child: Stack(
  //                   children: [
  //                     InkWell(
  //                       onTap: () => chooseImage(),
  //                       child: Icon(Icons.edit),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }
  //         }),
  //         Container(
  //           child: ElevatedButton(
  //             child: Text("Upload"),
  //             onPressed: () => uploadImg(),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse("uri");
    var request = new http.MultipartRequest('POST', uri);

    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();
    final headers = {'Authorization': 'Token $token'};

    request.headers.addAll(headers);
    var multiport = new http.MultipartFile('image', stream, length);

    request.files.add(multiport);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        GestureDetector(
          onTap: () => getImage(),
          child: Container(
            child: image == null
                ? Center(child: Text('Pick Image'))
                : Container(
                    child: Center(
                        child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )),
                  ),
          ),
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            uploadImage();
          },
          child: Container(
            child: Text('Upload'),
          ),
        )
      ]),
    );
  }
}
