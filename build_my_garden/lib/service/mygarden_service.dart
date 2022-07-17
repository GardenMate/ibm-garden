import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';

// main() async{
//   ListOfPlants listOfPlants = await PlantService.getPlant();
//   print(listOfPlants.plants[0].user);
// }

class PlantService {
  Future<ListOfPlants> getPlant() async {
    String? token = await SecureStorage.getToken();

    var response = await http
        .get(Uri.parse("http://10.0.2.2:8000/api/mygarden/plant"), headers: {
      'Authorization': 'Token $token',
    });
    print(jsonDecode(response.body));
    return ListOfPlants.fromList(jsonDecode(response.body));
  }
}

class ListOfPlants {
  List<Plant> plants;
  ListOfPlants({required this.plants});
  factory ListOfPlants.fromList(List list) {
    List<Plant> _plants = [];
    list.forEach((element) {
      _plants.add(Plant.fromJson(element));
    });
    return ListOfPlants(plants: _plants);
  }
}

class Plant {
  int user;
  int plant_type;
  int plant_current_size_height;
  int plant_current_size_spread;
  String planted_date;
  String image;

  Plant({
    required this.user,
    required this.plant_type,
    required this.plant_current_size_height,
    required this.plant_current_size_spread,
    required this.planted_date,
    required this.image,
  });

  factory Plant.fromJson(map) {
    return Plant(
        user: map['user'],
        plant_type: map['plant_type'],
        plant_current_size_height: map['plant_current_size_height'],
        plant_current_size_spread: map['plant_current_size_spread'],
        planted_date: map['planted_date'],
        image: map['image']);
  }
}
