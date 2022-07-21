import 'dart:io';

import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddImageService {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  XFile? pickedFile;

  Future getImage() async {
    pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile!.path);
      print("Image selected");
      // setState(() {});
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadImage(String listingID) async {
    // setState(() {
    //   showSpinner = true;
    // });

    // Stream=Change the image file tp bytes
    // Length=Gets the length of the image?
    // uri=Gets the uri that will be used
    // [To DO]: Create an error catcher for when image isn't uploaded
    var stream = image!.readAsBytes().asStream();
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("$baseUrl/api/image/add/");
    String filename = pickedFile!.path.split("/").last;

    // Multiport=Packages the image into a movable packet - removed await
    var multiport =
        http.MultipartFile('image', stream, length, filename: filename);

    // New Postman suggestion - change listing to be dynamic
    var request = http.MultipartRequest('POST', uri);
    // Add listing and the multiport to the body
    request.fields.addAll({'listing': listingID});
    request.files.add(multiport);

    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();
    final headers = {
      'Authorization': 'Token $token',
    };
    // Add the header to the request
    request.headers.addAll(headers);
    var response = await request.send();

    if (response.statusCode == 201) {
      print('Image Uploaded');
      print(await response.stream.bytesToString());
    } else {
      print(await response.stream.bytesToString());
    }
  }
}
