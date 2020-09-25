import 'package:flutter/material.dart';

Widget titleItem({
  @required data,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        data.name,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}

Widget subTitleItem({
  @required data,
}) {
  if (data.shop == null) {
    return Text(
      data.date,
      style: TextStyle(fontSize: 10),
    );
  } else {
    var timeline = data.date + ' - ' + data.shop;
    return Text(
      timeline,
      style: TextStyle(fontSize: 10),
    );
  }
}