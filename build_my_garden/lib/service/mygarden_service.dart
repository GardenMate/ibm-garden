import 'dart:io';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// main() async{
//   ListOfPlants listOfPlants = await PlantService.getPlant();
//   print(listOfPlants.plants[0].user);
// }


// Plant Service Class
class PlantService {
  // These are the attributes of the PlantService class
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  XFile? pickedFile;
  Future getImage() async {
    pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile!.path);
      print("Image selected");
      // setState(() {});
    } else {
      print('No image selected');
    }
  }

  // This is the method to post a plant from the user side
  Future<void> uploadPlant(
      String plant_type,
      String soil_planted,
      String plant_current_size_height,
      String plant_current_size_spread,
      String planted_date) async {
    var stream = image!.readAsBytes().asStream();
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("$baseUrl/api/mygarden/plant/");
    String filename = pickedFile!.path.split("/").last;

    var multiport =
        http.MultipartFile('image', stream, length, filename: filename);

    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'plant_type': plant_type.toString(),
      'soil_planted': soil_planted.toString(),
      'plant_current_size_height': plant_current_size_height.toString(),
      'plant_current_size_spread': plant_current_size_spread.toString(),
      'planted_date': planted_date
    });
    request.files.add(multiport);

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

  // This is the method to get all the plants from the user side

  // This is the method to get all the plants from the user side and display them in the app
  Future<ListOfPlants> getPlant() async {
    String? token = await SecureStorage.getToken();

    var response =
        await http.get(Uri.parse("$baseUrl/api/mygarden/plant"), headers: {
      'Authorization': 'Token $token',
    });
    print(response.body);

    return ListOfPlants.fromList(jsonDecode(response.body));
  }

  Future<ListOfPlants> getSearchPlant(String search) async {
    String? token = await SecureStorage.getToken();

    var response = await http.get(
        Uri.parse("$baseUrl/api/mygarden/plant/search/?search=$search"),
        headers: {
          'Authorization': 'Token $token',
        });

    return ListOfPlants.fromList(jsonDecode(response.body));
  }
}

class SoilServices {
  Future postSoil() async {
    String? token = await SecureStorage.getToken();

    var response =
        await http.post(Uri.parse("$baseUrl/api/mygarden/soil/"), headers: {
      'Authorization': 'Token $token',
    });
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
  int soil_planted;
  double plant_current_size_height;
  double plant_current_size_spread;
  String planted_date;
  String image;
  String harvest_length;

  Plant({
    required this.user,
    required this.plant_type,
    required this.soil_planted,
    required this.plant_current_size_height,
    required this.plant_current_size_spread,
    required this.planted_date,
    required this.image,
    required this.harvest_length,
  });

  factory Plant.fromJson(map) {
    return Plant(
        user: map['user'],
        plant_type: map['plant_type'],
        soil_planted: map['soil_planted'],
        plant_current_size_height: map['plant_current_size_height'].toDouble(),
        plant_current_size_spread: map['plant_current_size_spread'].toDouble(),
        planted_date: map['planted_date'],
        image: map['image'],
        harvest_length: map['harvest_length']);
  }
}
