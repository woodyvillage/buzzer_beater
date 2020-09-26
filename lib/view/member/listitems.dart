import 'dart:io';
import 'package:flutter/material.dart';

Widget imageItem({
  @required data,
}) {
  if (data.image != null) {
    return Image.file(
      File(data.image),
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      'images/noimage.png',
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    );
  }
}

Widget titleItem({
  @required data,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        data.name,
        style: TextStyle(fontSize: 22),
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