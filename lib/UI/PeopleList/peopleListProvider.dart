import 'package:flutter/material.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/repository/Peoplerepository.dart';

class PeopleProvider extends ChangeNotifier {
  List<People> people;
  PeopleRepository _peopleRepository = PeopleRepository();
  int page = 2;

  PeopleProvider() {
    print('$page executed');
    getPeople();
  }

  void getPeople() async {
    await _peopleRepository.fetchPeople(page).then((newPeople) {
      print(newPeople);
      people = newPeople;
      page++;
      print(page);
      notifyListeners();
    });
  }
}
