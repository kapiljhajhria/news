import 'package:flutter/material.dart';
import 'screens/newslist_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Awesome News",
      home: NewsList(),
    );
  }
}
