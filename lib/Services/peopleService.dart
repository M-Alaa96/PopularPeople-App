import 'dart:convert';
import 'package:flutter_task/Models/Details.dart';
import 'package:flutter_task/Models/Images.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:http/http.dart' as http;

class PeopleService {
  Future<List<People>> fetchPeople(int page) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/person/popular?api_key=5b2a718c567ecffddd317a6fbafb8a1c&language=en-US&page=${page}');
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> data = json.decode(response.body);
      print(data['results']);
      return List<People>.from(
          (data['results'] as List).map((e) => People.fromJson((e)))).toList();
    } else {
      throw Exception('FAILED TO LOAD POST');
    }
  }

  Future<Details> fetchDetails(int id) async {
    final response = await http.get(
        'https://api.themoviedb.org/3/person/$id?api_key=5b2a718c567ecffddd317a6fbafb8a1c&language=en-US');
    if (response.statusCode == 200) {
      print(response.body);
      return detailsFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD POST');
    }
  }
    Future<Images> fetchImages(int id) async {
    final response = await http.get(
      'https://api.themoviedb.org/3/person/$id/images?api_key=5b2a718c567ecffddd317a6fbafb8a1c');
    if (response.statusCode == 200) {
      print(response.body);
      return imagesFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD POST');
    }
  }
}
