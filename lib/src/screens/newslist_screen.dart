import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_bloc.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hacker News"),
      ),
      body: Center(
        child: buildList(bloc),
      ),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (snapshot.hasData)
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          );
        return CircularProgressIndicator(
          backgroundColor: Colors.redAccent,
          strokeWidth: 10.0,
        );
      },
    );
  }
}
