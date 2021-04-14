import 'package:flutter/material.dart';
import 'package:flutter_task/Models/Details.dart';
import 'package:flutter_task/Models/Images.dart';
import 'package:flutter_task/Repository/peopleRepository.dart';

class DetailsProvider extends ChangeNotifier {
  // Future<Details> details;
  Details details;
  Images images;
  PeopleRepository _peopleRepository = PeopleRepository();
  // int page = 1;

  DetailsProvider(int id) {
    getDetails(id);
    getImages(id);
  }

  void getDetails(int id) {
    _peopleRepository.fetchDetails(id).then((newDetails) {
      print(newDetails);
      details = newDetails;
      notifyListeners();
    });
  }

  void getImages(int id) {
    _peopleRepository.fetchImages(id).then((newImages) {
      print(newImages);
      images = newImages;
      notifyListeners();
    });
  }
}
