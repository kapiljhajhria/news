import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../bloc/stories_provider.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key key, this.itemId}) : super(key: key);

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("itemid is $itemId");
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
        stream: bloc.items,
        builder: (BuildContext context,
            AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) return LoadingContainer();
          // print("got data for itemid $itemId");
          return FutureBuilder(
            future: snapshot.data[itemId],
            builder:
                (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return LoadingContainer();
              }
              return buildTile(itemSnapshot.data, context);
            },
          );
        });
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: GestureDetector(
              onTap: () {
                launchUrl(item.url);
              },
              child: Text(item.title)),
          subtitle: Text(item.score.toString() + " points"),
          trailing: buildComments(item, context),
          onTap: () {},
        ),
        Divider(
          height: 8,
        )
      ],
    );
  }

  buildComments(ItemModel item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/${item.id}");
      },
      child: Column(
        children: [Icon(Icons.comment), Text(item.descendants.toString())],
      ),
    );
  }
}
