import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.itemId, this.itemMap});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return Text("fetching comment");

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: Text(item.text),
            subtitle: Text(item.by.isEmpty ? "deleted" : item.by),
          )
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }
}
