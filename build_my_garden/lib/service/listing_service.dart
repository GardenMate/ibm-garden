import 'dart:convert';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListingService {
  Future<ListOfListing> getListing(
      [String? city, String? latitude, String? longitude]) async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    if (city != "null") {
      var response = await http.get(
        Uri.parse('$baseUrl/api/listing/?city=$city'),
        headers: {
          'Authorization': 'Token $token',
        },
      );
      return ListOfListing.fromList(jsonDecode(response.body));
      // If city is not provided but latitude and longitude is provided
    } else {
      var city = await http.get(
        Uri.parse(
            '$baseUrl/api/location/?latitude=$latitude&longitude=$longitude'),
        headers: {
          'Authorization': 'Token $token',
        },
      );

      // Get city and store
      await SecureStorage.setCity(jsonDecode(city.body)['city']);

      var response = await http.get(
        Uri.parse(
            '$baseUrl/api/listing/?latitude=$latitude&longitude=$longitude'),
        headers: {
          'Authorization': 'Token $token',
        },
      );
      return ListOfListing.fromList(jsonDecode(response.body));
    }
  }

  Future<ListOfListing> getSellersListing() async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    var response = await http.get(
      Uri.parse('$baseUrl/api/seller/listing/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    return ListOfListing.fromList(jsonDecode(response.body));
  }

  Future<ListOfListing> getSearchListing(String search) async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    var response = await http.get(
      Uri.parse('$baseUrl/api/listing/search/?search=$search'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    return ListOfListing.fromList(jsonDecode(response.body));
  }

  Future<SingleListing> getDetailListing(int id) async {
    // Store and reformate token correctly
    String? token = await SecureStorage.getToken();

    // Uri parse should always pass the token in the header for authentication
    var response = await http.get(
      Uri.parse('$baseUrl/api/listing/details/?id=$id'),
      headers: {
        'Authorization': 'Token $token',
      },
    );
    return SingleListing.fromJson(jsonDecode(response.body));
  }

  Future<AddListingResponse> postListing(
      String title,
      String desc,
      String price,
      String type,
      String qty,
      String unit,
      String location,
      String distanceFromLocation) async {
    // POST request for the listing
    String? token = await SecureStorage.getToken();

    var response =
        await http.post(Uri.parse("$baseUrl/api/seller/listing/"), headers: {
      'Authorization': 'Token $token',
    }, body: {
      "title": title,
      "description": desc,
      "price": price,
      "plant_type": type,
      "quantity": qty,
      "quantity_type": unit,
      "location": location,
      "distance_from_location": distanceFromLocation
    });
    print(response.body);
    return AddListingResponse.fromJson(jsonDecode(response.body));
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

// Adding a class called listing 
// This class will be used to store the data from the API
class Listing {
  // Different variables that will be used to store the data from the API
  int id;
  String title;
  String description;
  double quantity;
  String quantity_type;
  double price;
  String price_currency;
  double distance_from_location;
  int seller_id;
  int location_id;
  double seller_rating;
  String plant_type;
  String address;
  String image;

  // Constructor for the class
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

  // This function will be used to convert the json data from the API into a class
  factory Listing.fromJson(map) {
    return Listing(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      quantity: map['quantity'].toDouble(),
      quantity_type: map['quantity_type'],
      price: map['price'].toDouble(),
      price_currency: map['price_currency'],
      distance_from_location: map['distance_from_location'].toDouble(),
      seller_id: map['seller'],
      plant_type: map['plant_type'],
      location_id: map['location'],
      seller_rating: map['seller_rating'].toDouble(),
      address: map['address'],
      image: map['image'],
    );
  }
}

// Adding a class called listing
class AddListingResponse {
  dynamic id;

  AddListingResponse({this.id});

  factory AddListingResponse.fromJson(mapOfBody) {
    return AddListingResponse(id: mapOfBody['id']);
  }
}

// Adding a class called listing
class SingleListing {
  int id;
  String title;
  String description;
  double quantity;
  String quantity_type;
  double price;
  String price_currency;
  double distance_from_location;
  int seller_id;
  String seller_username;
  String seller_first_name;
  String seller_last_name;
  int location_id;
  double seller_rating;
  String plant_type;
  String city;
  List<dynamic> image;

  SingleListing({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.quantity_type,
    required this.price,
    required this.price_currency,
    required this.distance_from_location,
    required this.seller_id,
    required this.seller_username,
    required this.seller_first_name,
    required this.seller_last_name,
    required this.location_id,
    required this.seller_rating,
    required this.plant_type,
    required this.city,
    required this.image,
  });

  factory SingleListing.fromJson(map) {
    return SingleListing(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      quantity: map['quantity'].toDouble(),
      quantity_type: map['quantity_type'],
      price: map['price'].toDouble(),
      price_currency: map['price_currency'],
      distance_from_location: map['distance_from_location'].toDouble(),
      seller_id: map['seller'],
      seller_username: map['seller_username'],
      seller_first_name: map['seller_first_name'],
      seller_last_name: map['seller_last_name'],
      plant_type: map['plant_type'],
      location_id: map['location'],
      city: map['city'],
      seller_rating: map['seller_rating'].toDouble(),
      image: map['image'],
    );
  }
}
