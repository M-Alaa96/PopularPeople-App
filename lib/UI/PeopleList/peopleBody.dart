import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/Bloc/people_bloc.dart';
import 'package:flutter_task/Bloc/people_event.dart';
import 'package:flutter_task/Bloc/people_state.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/UI/PeopleList/peopleCard.dart';

class PeopleBody extends StatefulWidget {
  @override
  _PeopleBodyState createState() => _PeopleBodyState();
}

class _PeopleBodyState extends State<PeopleBody> {
  final List<People> _people = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<PeopleBloc, PeopleState>(
        listener: (context, peopleState) {
          if (peopleState is PeopleLoadingState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(peopleState.message)));
          } else if (peopleState is PeopleSuccessState &&
              peopleState.people.isEmpty) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('No more people')));
          } else if (peopleState is PeopleErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(peopleState.error)));
            BlocProvider.of<PeopleBloc>(context).isFetching = false;
          }
          return;
        },
        builder: (context, beerState) {
          if (beerState is PeopleInitialState ||
              beerState is PeopleLoadingState && _people.isEmpty) {
            return CircularProgressIndicator();
          } else if (beerState is PeopleSuccessState) {
            _people.addAll(beerState.people);
            BlocProvider.of<PeopleBloc>(context).isFetching = false;
            Scaffold.of(context).hideCurrentSnackBar();
          } else if (beerState is PeopleErrorState && _people.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<PeopleBloc>(context)
                      ..isFetching = true
                      ..add(PeopleFetchEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(beerState.error, textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !BlocProvider.of<PeopleBloc>(context).isFetching) {
                  BlocProvider.of<PeopleBloc>(context)
                    ..isFetching = true
                    ..add(PeopleFetchEvent());
                }
              }),
            itemBuilder: (context, index) => PeopleCard(_people[index], index),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _people.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
