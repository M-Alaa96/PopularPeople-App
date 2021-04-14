import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PeoplesRepository {
  static final PeoplesRepository _peopleRepository = PeoplesRepository._();
  // static const int _perPage = 10;

  PeoplesRepository._();

  factory PeoplesRepository() {
    return _peopleRepository;
  }

  Future<dynamic> getPeople({
    @required int page,
  }) async {
    try {
      return await http.get(
        'https://api.themoviedb.org/3/person/popular?api_key=5b2a718c567ecffddd317a6fbafb8a1c&language=en-US&page=${page}',
      );
    } catch (e) {
      return e.toString();
    }
  }
}