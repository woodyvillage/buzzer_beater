import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// import 'package:buzzer_beater/view/analysis/body.dart';
import 'package:buzzer_beater/view/match/body.dart';
import 'package:buzzer_beater/view/member/body.dart';
import 'package:buzzer_beater/view/result/body.dart';
import 'package:buzzer_beater/view/roster/body.dart';
import 'package:buzzer_beater/view/team/body.dart';

const int routesetTeam = 0;
const int routesetMember = 1;
const int routesetRoster = 2;
const int routesetMatch = 3;
const int routesetResult = 4;
// const int routesetAnalysis = 4;

final routesetIcon = [
  Icon(Icons.home),
  Icon(Icons.group),
  Icon(Icons.format_list_numbered),
  Icon(Icons.timer),
  Icon(Icons.history),
  // Icon(Icons.multiline_chart),
];

final routesetText = [
  Text('チーム'),
  Text('メンバー'),
  Text('ロースター'),
  Text('試合'),
  Text('履歴'),
  // Text('分析'),
];

final routesetClass = [
  TeamBoard(),
  MemberBoard(),
  RosterBoard(),
  MatchBook(),
  ResultBook(),
  // AnalysisList(),
];

final routesetFloatIcon = [
  Icon(Icons.add),
  Icon(Icons.person_add),
  Icon(Icons.playlist_add),
  Icon(Icons.add),
  Icon(Icons.add),
  null,
];

final routesetFloatText = [
  Text('チーム追加'),
  Text('メンバー追加'),
  Text('メンバー登録'),
  Text('試合開始'),
  Text('試合開始'),
  null,
];
