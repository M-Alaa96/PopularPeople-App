import 'package:flutter/material.dart';
import 'package:flutter_task/Models/Images.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Models/Details.dart';
import 'package:flutter_task/UI/Images/images.dart';
import 'package:flutter_task/UI/PeopleDetails/peopleDetailsProvider.dart';
import 'package:provider/provider.dart';

class PeopleDetails extends StatelessWidget {
  final People popularPerson;
  List<KnownFor> work;
  final index;

  // final int index;

  @override
  PeopleDetails({Key key, @required this.popularPerson, this.index})
      : super(key: key);
  Widget build(BuildContext context) {
    work = popularPerson.knownFor.toList();
    print(work[0].title);
    return Scaffold(
        appBar: AppBar(
          title: Text(popularPerson.name),
        ),
        backgroundColor: Colors.blue[100],
        body: ChangeNotifierProvider<DetailsProvider>(
            create: (context) => DetailsProvider(popularPerson.id),
            child: Consumer<DetailsProvider>(
                builder: (buildContext, detailsProvider, _) {
              final personDetails = detailsProvider.details;
              final images = detailsProvider.images;
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Hero(
                            tag: 'PersonImage${popularPerson.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${popularPerson.profilePath}',
                                // width: 600,
                                // height: 100,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  popularPerson.name,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                popularPerson.popularity.toString(),
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Born",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              (() {
                                if (personDetails != null) {
                                  return "${personDetails.birthday.day}/${personDetails.birthday.month}/${personDetails.birthday.year} in ${personDetails.placeOfBirth}";
                                } else {
                                  return "Loading...";
                                }
                              })(),
                              style: TextStyle(fontSize: 18),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Biography",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              (() {
                                if (personDetails != null) {
                                  return "${personDetails.biography}";
                                } else {
                                  return "Loading...";
                                }
                              })(),
                              style: TextStyle(fontSize: 18),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Movies",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                            itemCount: work.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, top: 8.0, bottom: 8.0),
                                      child: Hero(
                                        tag: 'PersonImage$index',
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500/${work[index].posterPath}',
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              work[index].title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                work[index].overview,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Images",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                            itemCount: images.profiles.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return (images.profiles != null)
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageDetails(
                                              imagePath: images.profiles[index].filePath,
                                              title:personDetails.name,
                                              index: index
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              bottom: 8.0),
                                          child: Hero(
                                            tag: 'Image$index',
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500/${images.profiles[index].filePath}',
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Text(
                        //     "Description",
                        //     style:
                        //         TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ],
                    )),
              );
            })));
  }
}
