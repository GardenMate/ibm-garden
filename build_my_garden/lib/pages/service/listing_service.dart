import 'dart:convert';
import 'package:build_my_garden/pages/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListingService {
  Future<ListOfListing> getListing() async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    var response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/listing/?latitude=43.52694005203881&longitude=-96.73868318893787'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    return ListOfListing.fromList(jsonDecode(response.body));
  }
}

class ListOfListing {
  List<Listing> listings;
  ListOfListing({required this.listings});

  factory ListOfListing.fromList(List list) {
    List<Listing> _listings = [];
    list.forEach((element) {
      _listings.add(Listing.fromJson(element));
    });
    return ListOfListing(listings: _listings);
  }
}

class Listing {
  int id;
  String title;
  String description;
  int quantity;
  String quantity_type;
  String price;
  String price_currency;
  int distance_from_location;
  int seller_id;
  int location_id;
  int seller_rating;
  String plant_type;
  String address;
  String image;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.quantity_type,
    required this.price,
    required this.price_currency,
    required this.distance_from_location,
    required this.seller_id,
    required this.location_id,
    required this.seller_rating,
    required this.plant_type,
    required this.address,
    required this.image,
  });

  factory Listing.fromJson(map) {
    return Listing(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      quantity: map['quantity'],
      quantity_type: map['quantity_type'],
      price: map['price'],
      price_currency: map['price_currency'],
      distance_from_location: map['distance_from_location'],
      seller_id: map['seller'],
      plant_type: map['plant_type'],
      location_id: map['location'],
      seller_rating: map['seller_rating'],
      address: map['address'],
      image: map['image'],
    );
  }
}
