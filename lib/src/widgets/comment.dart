import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return Text("fetching comment");

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: Text(item.by.isEmpty ? "deleted" : item.by),
            contentPadding:
                EdgeInsets.only(left: (depth + 1) * 16.0, right: 16),
          )
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final String text = item.text
        .replaceAll("&#x27;", "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '\n\n');
    return Text(text);
  }
}
