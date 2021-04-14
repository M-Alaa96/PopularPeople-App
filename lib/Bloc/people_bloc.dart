import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_task/Bloc/people_event.dart';
import 'package:flutter_task/Bloc/people_state.dart';
import 'package:flutter_task/Database/dbHelper.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Repository/peopleBlocRepository.dart';
import 'package:flutter_task/Repository/peopleRepository.dart';
import 'package:flutter_task/Services/peopleService.dart';
import 'package:http/http.dart' as http;

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  // final PeopleRepository peopleRepository;
  final PeoplesRepository peoplesRepository;

  int page = 1;
  bool isFetching = false;

  PeopleBloc({
    @required this.peoplesRepository,
  }) : super(PeopleInitialState());

  // @override
  // Stream<PeopleState> mapEventToState(PeopleEvent event) async* {
  //   if (event is PeopleFetchEvent) {
  //     yield PeopleLoadingState(message: 'Loading People');
  //     final response = await peoplesRepository.getPeople(page: page);
  //     if (response is http.Response) {
  //       if (response.statusCode == 200) {
  //         Map<String, dynamic> data = json.decode(response.body);
  //         print(data["results"]);
  //         final people = List<People>.from(
  //                 (data['results'] as List).map((e) => People.fromJson((e))))
  //             .toList();
  //         ;
  //         yield PeopleSuccessState(
  //           people: people,
  //         );
  //         page++;
  //       } else {
  //         yield PeopleErrorState(error: response.body);
  //       }
  //     } else if (response is String) {
  //       yield PeopleErrorState(error: response);
  //     }
  //   }
  // }
  Stream<PeopleState> mapEventToState(PeopleEvent event) async* {
    if (event is PeopleFetchEvent) {
      yield PeopleLoadingState(message: 'Loading People');
      var connectivityResult = await (Connectivity().checkConnectivity());
      print(ConnectivityResult.mobile);
      final dbHelper = DbHelper.instance;
      // if there is not a network, return saved posts in db
      if (connectivityResult == ConnectivityResult.none) {
        print("DATABASEEE");
        final savedPeople = await dbHelper.queryAllRows();
        final peopleList = List<People>.from(
            savedPeople.map((savedPeople) => People.fromJson(savedPeople)));
        yield PeopleSuccessState(
          people: peopleList,
        );
      } else {
        final response = await peoplesRepository.getPeople(page: page);
        if (response is http.Response) {
          if (response.statusCode == 200) {
            Map<String, dynamic> data = json.decode(response.body);
            print(data["results"]);
            final people = List<People>.from(
                    (data['results'] as List).map((e) => People.fromJson((e))))
                .toList();
            for (final person in people) {
              dbHelper.insert(person.toMap());
            }
            yield PeopleSuccessState(
              people: people,
            );
            page++;
          } else {
            yield PeopleErrorState(error: response.body);
          }
        } else if (response is String) {
          yield PeopleErrorState(error: response);
        }
      }
    }
  }

  static PeopleService() {}
}
