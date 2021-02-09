import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;
  NewsDetails({this.itemId});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Text("Comments here for $itemId"),
    );
  }
}
