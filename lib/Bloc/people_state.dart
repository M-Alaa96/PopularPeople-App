import 'package:flutter_task/Models/People.dart';
import 'package:flutter/foundation.dart';

abstract class PeopleState {
  const PeopleState();
}

class PeopleInitialState extends PeopleState {
  const PeopleInitialState();
}

class PeopleLoadingState extends PeopleState {
  final String message;

  const PeopleLoadingState({
    @required this.message,
  });
}

class PeopleSuccessState extends PeopleState {
  final List<People> people;

  const PeopleSuccessState({
    @required this.people,
  });
}

class PeopleErrorState extends PeopleState {
  final String error;

  const PeopleErrorState({
    @required this.error,
  });
}
