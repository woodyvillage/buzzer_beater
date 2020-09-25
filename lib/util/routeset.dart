import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/analysis/body.dart';
import 'package:buzzer_beater/view/match/body.dart';
import 'package:buzzer_beater/view/member/body.dart';
import 'package:buzzer_beater/view/setting/body.dart';
import 'package:buzzer_beater/view/team/body.dart';

const int routesetTeam = 0;
const int routesetMember = 1;
const int routesetMatch = 2;
const int routeset = 3;
const int routesetConfig = 4;

final routesetIcon = [
  Icon(Icons.home),
  Icon(Icons.face),
  Icon(Icons.content_paste),
  Icon(Icons.multiline_chart),
  Icon(Icons.settings),
];

final routesetText = [
  Text('チーム'),
  Text('メンバー'),
  Text('試合'),
  Text('分析'),
  Text('設定'),
];

final routesetClass = [
  TeamBoard(),
  MemberList(),
  MatchList(),
  AnalysisList(),
  Setting(),
];

final routesetFloatIcon = [
  Icon(Icons.add),
  Icon(Icons.person_add),
  Icon(Icons.add),
  Icon(Icons.restaurant),
  Icon(Icons.add),
];

final routesetFloatText = [
  Text('追加'),
  Text('追加'),
  Text('入金'),
  Text('支払'),
  Text('入金'),
];
