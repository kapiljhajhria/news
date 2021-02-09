import 'package:flutter/material.dart';
import 'screens/newslist_screen.dart';
import 'bloc/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: "Awesome News",
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) {
            return NewsList();
          });
        },
      ),
    );
  }
}
