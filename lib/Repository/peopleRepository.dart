import 'package:flutter_task/Models/Images.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Models/Details.dart';
import 'package:flutter_task/Services/peopleService.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_task/Database/dbHelper.dart';

class PeopleRepository {
  PeopleService _peopleService = PeopleService();

  Future<List<People>> fetchPeople(int page) async {
    // get the network status
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(ConnectivityResult.mobile);
    final dbHelper = DbHelper.instance;
    // if there is not a network, return saved posts in db
    if (connectivityResult == ConnectivityResult.none) {
      print("DATABASEEE");
      final savedPeople = await dbHelper.queryAllRows();
      List<People> peopleList = List<People>.from(
          savedPeople.map((savedPeople) => People.fromJson(savedPeople)));

      return peopleList;
    } else {
      final people = await _peopleService.fetchPeople(page);
      print('Ana henaa');
      // for (final person in people) {
      //   dbHelper.insert(person.toMap());
      // }
      return people;
    }
  }

    Future<Images> fetchImages(int id) {
    return _peopleService.fetchImages(id);
  }

  Future<Details> fetchDetails(int id) {
    return _peopleService.fetchDetails(id);
  }
}
