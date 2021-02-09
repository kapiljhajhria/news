import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/bloc/comments_provider.dart';
import 'package:news/src/models/item_model.dart';
import '../models/item_model.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;
  NewsDetails({this.itemId});

  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) return Text("loading..........");

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) Text("fetching comments data......");
            return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }
}
