import 'dart:io';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/team.dart';

Widget teamBoardSubSet({
  @required TeamDto data,
  @required BuildContext context,
}) {
  return Card(
    elevation: 8,
    color: Theme.of(context).cardColor,
    margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
    child: Container(
      height: 110,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageItem(data: data, size: 80),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleItem(data: data),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.96, 0.96],
          colors: [
            Theme.of(context).canvasColor,
            Color(data.awayMain),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
  );
}

Widget imageItem({
  @required dynamic data,
  @required double size,
}) {
  // imageプロパティ
  if (data.image != null) {
    return Image.file(
      File(data.image),
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      'images/noimage.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}

Widget titleItem({
  @required dynamic data,
}) {
  String _age;
  if (data is TeamDto) {
    double _size = data.name.length > 10 ? 22 : 24;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.name,
          style: TextStyle(fontSize: _size),
        ),
      ],
    );
  } else if (data is MemberDto) {
    _age = data.age == 0 ? '不明' : data.age.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              data.name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '  (' + _age + ')',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  } else if (data is PlayerDto) {
    _age = data.age == 0 ? '不明' : data.age.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              data.name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '  (' + _age + ')',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  } else if (data is ResultDto) {
    var _place = data.match.place == null
        ? ''
        : ' - ' + data.match.place + '(' + data.match.coat + ')';
    return SizedBox(
      height: 58,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.match.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            Text(
              data.match.date + _place,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  } else {
    return null;
  }
}

Widget roundNumberItem({
  @required BuildContext context,
  @required TeamDto team,
  @required dynamic member,
}) {
  Color _mainColor;
  Color _edgeColor;
  Color _fontColor;
  Text _child;
  if (member.number == null) {
    _mainColor = Theme.of(context).canvasColor;
    _edgeColor = Theme.of(context).canvasColor;
    _fontColor = Theme.of(context).canvasColor;
    _child = Text('');
  } else {
    if (team.awayMain == team.awayEdge) {
      _mainColor = Color(team.awayMain);
      _edgeColor = Color(team.awayEdge);
      _fontColor = Theme.of(context).canvasColor;
    } else {
      _mainColor = Color(team.awayMain);
      _edgeColor = Color(team.awayEdge);
      _fontColor = Color(team.awayEdge);
    }
    if (member.number < 0) {
      _child = Text('');
    } else {
      _child = Text(
        member.number.toString(),
        style: TextStyle(
          color: _fontColor,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  return CircleAvatar(
    backgroundColor: _edgeColor,
    radius: 30,
    child: CircleAvatar(
      backgroundColor: _mainColor,
      radius: 24,
      child: _child,
    ),
  );
}
