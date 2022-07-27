import 'dart:convert';
import 'dart:io';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SellerInfoService {
  File? profileImage;
  File? dashboardImage;
  final _picker = ImagePicker();
  bool showSpinner = false;
  XFile? pickedProfileImage;
  XFile? pickedDashboardImage;
  Future getProfileImage() async {
    pickedProfileImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedProfileImage != null) {
      profileImage = File(pickedProfileImage!.path);
      print("Profile Image selected");
      // setState(() {});
    } else {
      print('No image selected');
    }
  }

  Future getDashboardImage() async {
    pickedDashboardImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedDashboardImage != null) {
      dashboardImage = File(pickedDashboardImage!.path);
      print("Dashboard Image selected");
      // setState(() {});
    } else {
      print('No image selected');
    }
  }

  Future<void> postSeller(String first_name, String last_name) async {
    var uri = Uri.parse("$baseUrl/api/seller/");

    var stream = profileImage!.readAsBytes().asStream();
    stream.cast();
    var length = await profileImage!.length();
    String filename = pickedProfileImage!.path.split("/").last;
    var profileMultiport = http.MultipartFile('profile_picture', stream, length,
        filename: filename);

    stream = dashboardImage!.readAsBytes().asStream();
    stream.cast();
    length = await dashboardImage!.length();
    filename = pickedDashboardImage!.path.split("/").last;
    var dashboardMultiport = http.MultipartFile(
        'dashboard_image', stream, length,
        filename: filename);

    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'first_name': first_name.toString(),
      'last_name': last_name.toString(),
    });
    request.files.add(profileMultiport);
    request.files.add(dashboardMultiport);

    String? token = await SecureStorage.getToken();
    final headers = {
      'Authorization': 'Token $token',
    };
    request.headers.addAll(headers);

    var response = await request.send();
    if (response.statusCode == 201) {
      print("Plant added");
      print(await response.stream.bytesToString());
    } else {
      print(await response.stream.bytesToString());
    }
  }

  Future<dynamic> getSellerInfo() async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    var response = await http.get(
      Uri.parse('$baseUrl/api/seller/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if (jsonDecode(response.body)['no_seller'] != null) {
      return SellerInfoError.fromJson(jsonDecode(response.body));
    } else {
      return SellerInfo.fromJson(jsonDecode(response.body));
    }
  }

  Future<SellerInfo> postSellerInfo(
    String username,
    String first_name,
    String last_name,
    String city,
    String seller_rating,
  ) async {
    // POST request for the SellerInfo
    String? token = await SecureStorage.getToken();

    var response = await http.post(Uri.parse("$baseUrl/api/seller/"), headers: {
      'Authorization': 'Token $token',
    }, body: {
      "username": username,
      "first_name": last_name,
      "last_name": last_name,
      "city": city,
      "seller_rating": seller_rating,
    });
    return SellerInfo.fromJson(jsonDecode(response.body));
  }

  Future postSellerAddress(
      [String? latitude, String? longitude, String? address]) async {
    // POST request for the SellerInfo
    String? token = await SecureStorage.getToken();

    if (address != null) {
      var response =
          await http.post(Uri.parse("$baseUrl/api/seller/address/"), headers: {
        'Authorization': 'Token $token',
      }, body: {
        "address": address,
      });
      // return SellerInfo.fromJson(jsonDecode(response.body));
    } else {
      var response =
          await http.post(Uri.parse("$baseUrl/api/seller/address/"), headers: {
        'Authorization': 'Token $token',
      }, body: {
        "latitude": latitude,
        "longitude": longitude,
      });
      // return SellerInfo.fromJson(jsonDecode(response.body));
    }
  }
}
// asdlkjglaj

// class ListOfSellerInfo {
//   List<SellerInfo> sellerInfo;
//   ListOfSellerInfo({required this.sellerInfo});

//   factory ListOfSellerInfo.fromList(List list) {
//     List<SellerInfo> _SellerInfos = [];
//     list.forEach((element) {
//       _SellerInfos.add(SellerInfo.fromJson(element));
//     });
//     return ListOfSellerInfo(sellerInfo: _SellerInfos);
//   }
// }

class SellerInfo {
  int id;
  String username;
  String first_name;
  String last_name;
  String city;
  double seller_rating;
  int user;
  String profile_picture;
  String dashboard_image;

  SellerInfo({
    required this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.city,
    required this.seller_rating,
    required this.user,
    required this.profile_picture,
    required this.dashboard_image,
  });

  factory SellerInfo.fromJson(map) {
    return SellerInfo(
      id: map['id'],
      username: map['username'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      city: map['city'],
      user: map['user'],
      seller_rating: map['seller_rating'].toDouble(),
      profile_picture: map['profile_picture'],
      dashboard_image: map['dashboard_image'],
    );
  }
}

class SellerInfoError {
  dynamic no_seller;

  SellerInfoError({
    this.no_seller,
  });

  factory SellerInfoError.fromJson(map) {
    return SellerInfoError(no_seller: map['no_seller']);
  }
}

class SellerInfoResponse {
  dynamic id;
  dynamic username;
  dynamic first_name;
  dynamic last_name;
  dynamic city;
  dynamic user;
  dynamic seller_rating;
  dynamic no_seller;

  SellerInfoResponse({
    this.id,
    this.username,
    this.first_name,
    this.last_name,
    this.city,
    this.user,
    this.seller_rating,
    this.no_seller,
  });

  factory SellerInfoResponse.fromJson(mapOfBody) {
    return SellerInfoResponse(
      id: mapOfBody['id'],
      username: mapOfBody['uesrname'],
      first_name: mapOfBody['first_name'],
      last_name: mapOfBody['last_name'],
      city: mapOfBody['city'],
      user: mapOfBody['user'],
      seller_rating: mapOfBody['seller_rating'],
      no_seller: mapOfBody['no_seller'],
    );
  }
}
