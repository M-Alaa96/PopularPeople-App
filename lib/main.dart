import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/UI/PeopleList/PeopleList.dart';
import 'package:flutter_task/UI/Favorites/favoritePeople.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FetchPeopleResponse(
      title: 'Popular People List',
    ),
    FavoritePeople(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          // Respond to item press.
          print(index);
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            title: Text('Favorites'),
            icon: Icon(Icons.favorite),
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
class PeopleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  // @override
  // void onChange(Cubit cubit, Change change) {
  //   print(change);
  //   super.onChange(cubit, change);
  // }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  // @override
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   print('$error, $stackTrace');
  //   super.onError(cubit, error, stackTrace);
  // }
}
