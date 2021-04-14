import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Bloc/people_bloc.dart';
import 'package:flutter_task/Bloc/people_event.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Repository/peopleBlocRepository.dart';
import 'package:flutter_task/UI/PeopleList/peopleBody.dart';

class FetchPeopleResponse extends StatefulWidget {
  final String title;

  const FetchPeopleResponse({Key key, this.title}) : super(key: key);
  @override
  _FetchPeopleResponseState createState() => _FetchPeopleResponseState();
}

class _FetchPeopleResponseState extends State<FetchPeopleResponse> {
  // Future<List<People>> futureMovies;
  // final _saved = <People>{};

  // ScrollController _scrollController = new ScrollController();

  // void _scrollListener() {
  //   if (controller.position.pixels == controller.position.maxScrollExtent) {
  //     var fetchPages = PeopleProvider(page);
  //     print("Current page: $page");
  //   }
  // }
  //

  @override
  void initState() {
    super.initState();
    // futureMovies = fetchMovies();
    // controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PeopleBloc(
        peoplesRepository: PeoplesRepository(),
      )..add(PeopleFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PeopleBody(),
      ),
    );
  }
}
