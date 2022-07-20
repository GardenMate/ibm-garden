import 'dart:convert';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SellerInfoService {
  Future<dynamic> getSellerInfo() async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/seller/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    print(response.body);
    if (jsonDecode(response.body)['no_seller'] != null) {
      print(jsonDecode(response.body)['no_seller']);
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

    var response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/seller/"), headers: {
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
}

// asdlkjglaj

// class ListOfSellerInfo {
//   List<SellerInfo> SellerInfos;
//   ListOfSellerInfo({required this.SellerInfos});

//   factory ListOfSellerInfo.fromList(List list) {
//     List<SellerInfo> _SellerInfos = [];
//     list.forEach((element) {
//       _SellerInfos.add(SellerInfo.fromJson(element));
//     });
//     return ListOfSellerInfo(SellerInfos: _SellerInfos);
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

  SellerInfo({
    required this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.city,
    required this.seller_rating,
    required this.user,
  });

  factory SellerInfo.fromJson(map) {
    return SellerInfo(
      id: map['id'],
      username: map['username'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      city: map['city'],
      user: map['user'],
      seller_rating: map['seller_rating'],
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

// class SellerInfoResponse {
//   dynamic id;
//   dynamic username;
//   dynamic first_name;
//   dynamic last_name;
//   dynamic city;
//   dynamic user;
//   dynamic seller_rating;
//   dynamic no_seller;

//   SellerInfoResponse({
//     this.id,
//     this.username,
//     this.first_name,
//     this.last_name,
//     this.city,
//     this.user,
//     this.seller_rating,
//     this.no_seller,
//   });

//   factory SellerInfoResponse.fromJson(mapOfBody) {
//     return SellerInfoResponse(
//       id: mapOfBody['id'],
//       username: mapOfBody['uesrname'],
//       first_name: mapOfBody['first_name'],
//       last_name: mapOfBody['last_name'],
//       city: mapOfBody['city'],
//       user: mapOfBody['user'],
//       seller_rating: mapOfBody['seller_rating'],
//       no_seller: mapOfBody['no_seller'],
//     );
//   }
// }
