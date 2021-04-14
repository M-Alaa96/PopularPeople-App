import 'package:flutter/material.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Services/peopleService.dart';
import 'package:flutter_task/repository/peopleRepository.dart';

class FavoritePeople extends StatefulWidget {
  @override
  _FavoritePeopleState createState() => _FavoritePeopleState();
}

class _FavoritePeopleState extends State<FavoritePeople> {
  Future<List<People>> futurePeople;
  void initState() {
    super.initState();
    futurePeople = PeopleRepository().fetchPeople(1);
    print(futurePeople);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<People>>(
        future: futurePeople,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final people = snapshot.data;
            return ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  final person = people[index];
                  return Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Image.network(person.profilePath,
                                        width: 100, height: 100)),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    person.name,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}