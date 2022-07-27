import 'dart:io';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';

class AddressService {
  Future<ListOfAddress> getAddress() async {
    String? token = await SecureStorage.getToken();
    final headers = {
      'Authorization': 'Token $token',
    };
    var response = await http.get(Uri.parse('$baseUrl/api/seller/address/'),
        headers: headers);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      print(ListOfAddress.fromList(json.decode(response.body)));
      return ListOfAddress.fromList(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load post');
    }
  }
}

class ListOfAddress {
  List<Address> addresses;
  ListOfAddress({required this.addresses});
  factory ListOfAddress.fromList(List list) {
    List<Address> address = [];
    list.forEach((element) {
      address.add(Address.fromJson(element));
    });
    return ListOfAddress(addresses: address);
  }

  
}

class Address {
  int id;
  int? seller;
  String? street_address;
  String? city;
  String? country;
  String? location;

  Address({
    required this.id,
    this.seller,
    this.street_address,
    this.city,
    this.country,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] == null ? null : json["id"],
        seller: json["seller"] == null ? null : json["seller"],
        street_address:
            json["street_address"] == null ? null : json["street_address"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        location: json["location"] == null ? null : json["location"],
      );
}
