import 'dart:io';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/team.dart';

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
  if (data is TeamDto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: TextStyle(fontSize: 22),
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget> [
            Text(
              data.name,
              style: TextStyle(fontSize: 22),
            ),
            Text(
              '  (' + data.age.toString() + ')',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}

Widget roundNumberItem({
  @required context,
  @required team,
  @required member,
}) {
  if (member.number == null) {
    return CircleAvatar(
      backgroundColor: Color(team.majormain),
      radius: 30,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).canvasColor,
        radius: 25,
        child: Text(''),
      ),
    );
  } else {
    return CircleAvatar(
      backgroundColor: Color(team.majormain),
      radius: 30,
      child: CircleAvatar(
        backgroundColor: Color(team.majorshade),
        radius: 25,
        child: Text(
          member.number.toString(),
          style: TextStyle(color: Color(team.majormain)),
        ),
      ),
    );
  }
}