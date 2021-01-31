import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_bloc.dart';
import 'package:news/src/bloc/stories_provider.dart';

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
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
              return Text(snapshot.data[index].toString());
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
