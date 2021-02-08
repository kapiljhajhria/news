import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../bloc/stories_provider.dart';
import 'dart:async';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("itemid is $itemId");
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) return Text("Stream still loading");
          print("got data for itemid $itemId");
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder:
                (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text("loading item data for id $itemId");
              }
              return Text(itemSnapshot.data.title);
            },
          );
        });
  }
}
