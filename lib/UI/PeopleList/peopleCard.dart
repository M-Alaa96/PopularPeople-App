import 'package:flutter/material.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/UI/PeopleDetails/peopleDetails.dart';

class PeopleCard extends StatelessWidget {
  // final _saved = <People>{};
  final index;
  final People popularPerson;
  const PeopleCard(this.popularPerson, this.index);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PeopleDetails(
              popularPerson: popularPerson,
              index: index,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                child: Hero(
                  tag: 'PersonImage${popularPerson.id}',
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${popularPerson.profilePath}',
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                          child: Text(
                        popularPerson.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(2.0),
                    //   child: Center(
                    //     child: Wrap(
                    //       children: movie.genreIds
                    //           .map((e) => Chip(
                    //                   label: Text(e,
                    //                 style:TextStyle(fontSize: 13),
                    //               )))
                    //           .toList(),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Known For: "),
                          Text(
                            popularPerson.knownForDepartment.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //     icon: alreadySaved
              //         ? Icon(Icons.favorite)
              //         : Icon(Icons.favorite_border),
              //     color: alreadySaved ? Colors.red : null,
              //     onPressed: () {
              //       setState(() {
              //         if (alreadySaved) {
              //           _saved.remove(popularPerson);
              //         } else {
              //           _saved.add(popularPerson);
              //         }
              //       });
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
