import 'package:flutter/material.dart';
import 'package:news/src/resources/news_db_provider.dart';
import '../bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
      },
    );
  }
}
