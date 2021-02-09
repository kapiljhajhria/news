import 'package:flutter/material.dart';
import 'package:news/src/screens/news_details_screen.dart';
import 'screens/newslist_screen.dart';
import 'bloc/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(title: "Awesome News", onGenerateRoute: routes),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    }
    final itemId = int.parse(settings.name.replaceFirst("/", ""));

    return MaterialPageRoute(builder: (context) {
      return NewsDetails(itemId: itemId);
    });
  }
}
