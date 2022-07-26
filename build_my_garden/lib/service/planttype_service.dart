import 'package:build_my_garden/service/base_url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';

class PlantTypeService {
  Future<ListOfPlantTypes> getPlantType() async {
    var uri = Uri.parse("$baseUrl/api/mygarden/planttype/");
    String? token = await SecureStorage.getToken();
    final headers = {
      'Authorization': 'Token $token',
    };
    var response = await http.get(uri, headers: headers);
    var jsonResponse = json.decode(response.body);
    return ListOfPlantTypes.fromJson(jsonResponse);
  }

  Future<ListOfPlantTypes> getSearchPlantTypes(String search) async {
    String? token = await SecureStorage.getToken();
    var uri =
        Uri.parse("$baseUrl/api/mygarden/planttype/search?search=$search");
    final headers = {
      'Authorization': 'Token $token',
    };
    var response = await http.get(uri, headers: headers);
    print(response.body);
    return ListOfPlantTypes.fromJson(jsonDecode(response.body));
  }
}

class ListOfPlantTypes {
  List<PlantType> plantTypes;
  ListOfPlantTypes({required this.plantTypes});
  factory ListOfPlantTypes.fromJson(List list) {
    List<PlantType> _plantTypes = [];
    list.forEach((element) {
      _plantTypes.add(PlantType.fromJson(element));
    });
    return ListOfPlantTypes(plantTypes: _plantTypes);
  }
}

class PlantType {
  String plant_name;
  String plant_scientific_name;
  String? plant_description;
  String? plant_type;
  double? plant_size_max_height_lowest;
  double? plant_size_max_height_highest;
  double? plant_size_max_spread_lowest;
  double? plant_size_max_spread_highest;
  String? plant_max_size_time_lowest;
  String? plant_max_size_time_highest;
  String? plant_harvest_length;
  List<dynamic>? planting_season;
  List<dynamic>? plant_harvest_season;
  String? sun_exposer;
  String? weather_exposer;
  double temperature_tolerance = 1.0;
  List<dynamic>? soil;
  List<dynamic>? plant_moisture_level;
  List<dynamic>? ph_level;
  String? plant_how_to_cultivate;
  String? plant_how_to_propagate;
  String? plant_how_to_garden_type;
  String? plant_how_to_pruning;
  String? plant_how_to_pests;
  String? plant_how_to_diseases;

  PlantType({
    required this.plant_name,
    required this.plant_scientific_name,
    this.plant_description,
    this.plant_type,
    this.plant_size_max_height_lowest,
    this.plant_size_max_height_highest,
    this.plant_size_max_spread_lowest,
    this.plant_size_max_spread_highest,
    this.plant_max_size_time_lowest,
    this.plant_max_size_time_highest,
    this.plant_harvest_length,
    this.planting_season,
    this.plant_harvest_season,
    this.sun_exposer,
    this.weather_exposer,
    // ignore: non_constant_identifier_names
    required this.temperature_tolerance,
    this.soil,
    this.plant_moisture_level,
    this.ph_level,
    this.plant_how_to_cultivate,
    this.plant_how_to_propagate,
    this.plant_how_to_garden_type,
    this.plant_how_to_pruning,
    this.plant_how_to_pests,
    this.plant_how_to_diseases,
  });
  factory PlantType.fromJson(Map<String, dynamic> json) {
    return PlantType(
      plant_name: json['plant_name'],
      plant_scientific_name: json['plant_scientific_name'],
      plant_description: json['plant_description'],
      plant_type: json['plant_type'],
      plant_size_max_height_lowest: json['plant_size_max_height_lowest'],
      plant_size_max_height_highest: json['plant_size_max_height_highest'],
      plant_size_max_spread_lowest: json['plant_size_max_spread_lowest'],
      plant_size_max_spread_highest: json['plant_size_max_spread_highest'],
      plant_max_size_time_lowest: json['plant_max_size_time_lowest'],
      plant_max_size_time_highest: json['plant_max_size_time_highest'],
      plant_harvest_length: json['plant_harvest_length'],
      planting_season: json['planting_season'],
      plant_harvest_season: json['plant_harvest_season'],
      sun_exposer: json['sun_exposer'],
      weather_exposer: json['weather_exposer'],
      temperature_tolerance: json['temperature_tolerance'] ?? 1.0,
      soil: json['soil'],
      plant_moisture_level: json['plant_moisture_level'],
      ph_level: json['ph_level'],
      plant_how_to_cultivate: json['plant_how_to_cultivate'],
      plant_how_to_propagate: json['plant_how_to_propagate'],
      plant_how_to_garden_type: json['plant_how_to_garden_type'],
      plant_how_to_pruning: json['plant_how_to_pruning'],
      plant_how_to_pests: json['plant_how_to_pests'],
      plant_how_to_diseases: json['plant_how_to_diseases'],
    );
  }
}
