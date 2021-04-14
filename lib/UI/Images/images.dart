import 'package:flutter/material.dart';
import 'package:flutter_task/Models/People.dart';
import 'package:flutter_task/Services/peopleService.dart';
import 'package:flutter_task/repository/peopleRepository.dart';

class ImageDetails extends StatelessWidget {
  final imagePath;
  final title;
  final index;
  ImageDetails({Key key, @required this.imagePath, this.title, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Hero(
          tag: 'Image$index',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/$imagePath',
              // width: 600,
              // height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
