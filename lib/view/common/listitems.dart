import 'dart:io';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/team.dart';

Widget imageItem({
  @required data,
  @required size,
}) {
  if (data.image != null) {
    return Image.file(
      File(data.image),
      width: size.toDouble(),
      height: size.toDouble(),
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      'images/noimage.png',
      width: size.toDouble(),
      height: size.toDouble(),
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
  } else if (data is MemberDto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget> [
            Text(
              data.name,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '  (' + data.age.toString() + ')',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  } else if (data is ResultDto) {
    var _place;
    data.match.place == null ? _place = '' : _place = ' - ' + data.match.place;
    return SizedBox(
      height: 50,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              data.match.name,
              style: TextStyle(fontSize: 20),
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

Widget teamPanelItem({
  @required data,
}) {
  return Row(
    children: <Widget> [
      Expanded(
        flex: 2,
        child: SizedBox(
          // height: 50,
        ),
      ),
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(data.home.majormain)),
              color: Color(data.home.majorshade),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: SizedBox(
          // height: 50,
        ),
      ),
      Expanded(
        flex: 45,
        child: Container(
          alignment: Alignment.centerLeft,
          // height: 50,
          child: teamNameItem(data: data.home),
        ),
      ),
      Expanded(
        flex: 45,
        child: Container(
          height: 50,
          child: teamNameItem(data: data.away),
        ),
      ),
      Expanded(
        flex: 1,
        child: SizedBox(
          height: 50,
        ),
      ),
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(data.away.majormain)),
              color: Color(data.away.majorshade),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: SizedBox(
          height: 50,
        ),
      ),
    ],
  );
}

Widget teamNameItem({
  @required data,
}) {
  return Text(
    data.name,
    style: TextStyle(fontSize: 16),
  );
}

Widget teamScoreItem({
  @required data,
}) {
  return Row(
    children: <Widget> [
      Expanded(
        flex: 35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Text(
              data.homescore.toString(),
              style: TextStyle(fontSize: 45),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            teamPeriodItem(data: data, index: 0),
            teamPeriodItem(data: data, index: 1),
            teamPeriodItem(data: data, index: 2),
            teamPeriodItem(data: data, index: 3),
            teamPeriodItem(data: data, index: 4),
          ],
        ),
      ),
      Expanded(
        flex: 35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Text(
              data.awayscore.toString(),
              style: TextStyle(fontSize: 45),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget teamPeriodItem({
  @required data,
  @required index,
}) {
  var _text;
  if (index == 4) {
    _text = '(延長)';
  } else {
    _text = '　－　';
  }
  if (data.homeperiod.length <= index || data.awayperiod.length <= index) {
    return Text(
      _text,
      style: TextStyle(fontSize: 16),
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Container(
          alignment: Alignment.center,
          width: 20,
          child: Text(
            data.homeperiod[index].score.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 60,
          child: Text(
            _text,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 20,
          child: Text(
            data.awayperiod[index].score.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
