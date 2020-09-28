import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/analysis/body.dart';
import 'package:buzzer_beater/view/match/body.dart';
import 'package:buzzer_beater/view/member/body.dart';
import 'package:buzzer_beater/view/result/body.dart';
import 'package:buzzer_beater/view/team/body.dart';

const int routesetTeam = 0;
const int routesetMember = 1;
const int routesetMatch = 2;
const int routesetResult = 3;
const int routesetConfig = 4;

final routesetIcon = [
  Icon(Icons.home),
  Icon(Icons.face),
  Icon(Icons.content_paste),
  Icon(Icons.history),
  Icon(Icons.multiline_chart),
];

final routesetText = [
  Text('チーム'),
  Text('メンバー'),
  Text('試合'),
  Text('履歴'),
  Text('設定'),
];

final routesetClass = [
  TeamBoard(),
  MemberList(),
  MatchList(),
  ResultBook(),
  AnalysisList(),
];

final routesetFloatIcon = [
  Icon(Icons.add),
  Icon(Icons.person_add),
  Icon(Icons.add),
  null,
  Icon(Icons.add),
];

final routesetFloatText = [
  Text('追加'),
  Text('追加'),
  Text('入金'),
  null,
  Text('入金'),
];