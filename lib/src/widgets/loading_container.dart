import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildGreyBox(),
          subtitle: buildGreyBox(),
        ),
        Divider(
          height: 8,
        )
      ],
    );
  }

  Widget buildGreyBox() {
    return Container(
      color: Colors.grey[200],
      height: 24,
      width: 150,
      margin: EdgeInsets.only(top: 5, bottom: 5),
    );
  }
}
