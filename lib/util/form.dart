import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final formIcon = [
  Icon(Icons.add_circle),
  Icon(Icons.cancel),
  Icon(Icons.remove_circle),
  Icon(Icons.add_circle),
  Icon(Icons.check_circle),
  Icon(Icons.play_circle_fill),
];

final formText = [
  Text('追加'),
  Text('取消'),
  Text('削除'),
  Text('登録'),
  Text('更新'),
  Text('開始'),
];

final formSubmit = 0;
final formCancel = 1;
final formDelete = 2;
final formRegist = 3;
final formUpdate = 4;
final formStart = 5;

// Team
final teams = [
  ['チーム名称', Icon(MaterialCommunityIcons.basketball), '', ''],
  [
    'ホームウェア（淡）',
    Icon(MaterialCommunityIcons.tshirt_crew_outline),
    Colors.white,
    Colors.grey,
  ],
  [
    'ビジターウェア（濃）',
    Icon(MaterialCommunityIcons.tshirt_crew),
    Colors.blue,
    Colors.lightBlue[100],
  ],
];

// Member
final members = [
  ['チーム', null, ''],
  ['氏名', null, ''],
  ['年齢', null, 0],
  ['登録番号', null, 0],
  ['背番号', null, 0],
  ['選手', null, true],
];

// Roster
final rosters = [
  ['チーム', null, ''],
  ['登録名', null, ''],
  ['登録選手1', null, ''],
  ['背番号', null, 0],
  ['登録選手2', null, ''],
  ['背番号', null, 0],
  ['登録選手3', null, ''],
  ['背番号', null, 0],
  ['登録選手4', null, ''],
  ['背番号', null, 0],
  ['登録選手5', null, ''],
  ['背番号', null, 0],
  ['登録選手6', null, ''],
  ['背番号', null, 0],
  ['登録選手7', null, ''],
  ['背番号', null, 0],
  ['登録選手8', null, ''],
  ['背番号', null, 0],
  ['登録選手9', null, ''],
  ['背番号', null, 0],
  ['登録選手10', null, ''],
  ['背番号', null, 0],
  ['登録選手11', null, ''],
  ['背番号', null, 0],
  ['登録選手12', null, ''],
  ['背番号', null, 0],
  ['登録選手13', null, ''],
  ['背番号', null, 0],
  ['登録選手14', null, ''],
  ['背番号', null, 0],
  ['登録選手15', null, ''],
  ['背番号', null, 0],
  ['コーチ', null, ''],
  ['背番号', null, false],
  ['アシスタントコーチ', null, ''],
  ['背番号', null, false],
];

// Match
final matchs = [
  ['試合名', null, ''],
  ['開催日', null, ''],
  ['場所', null, ''],
  ['コートNo', null, ''],
  ['ホームチーム', null, false],
  ['ロースター', null, 0],
  ['アウェイチーム', null, 0],
  ['ロースター', null, 0],
];

final functions = [
  [
    '1Q',
    MaterialCommunityIcons.numeric_1_circle_outline,
    Colors.orange,
    Colors.white
  ],
  [
    '2Q',
    MaterialCommunityIcons.numeric_2_circle_outline,
    Colors.orange,
    Colors.white
  ],
  [
    '3Q',
    MaterialCommunityIcons.numeric_3_circle_outline,
    Colors.orange,
    Colors.white
  ],
  [
    '4Q',
    MaterialCommunityIcons.numeric_4_circle_outline,
    Colors.orange,
    Colors.white
  ],
  [
    '延長',
    MaterialCommunityIcons.numeric_5_circle_outline,
    Colors.deepOrange,
    Colors.white
  ],
];

final actions = [
  ['タイムアウト', null, Colors.red, Colors.white],
  ['メンバー交代', null, Colors.red, Colors.white],
  ['フィールドゴール', null, Colors.deepPurple, Colors.white],
  ['フリースロー', null, Colors.deepPurple, Colors.white],
  ['オウンゴール', null, Colors.deepPurple, Colors.white],
  ['パーソナル', null, Colors.purple, Colors.white],
  ['テクニカル', null, Colors.purple, Colors.white],
  ['アンスポーツマンライク', null, Colors.purple, Colors.white],
  ['ディスクォリファイング', null, Colors.purple, Colors.white],
  ['チームファール', null, Colors.purple, Colors.white],
  ['０', null, Colors.amber, Colors.black],
  ['１', null, Colors.amber, Colors.black],
  ['２', null, Colors.amber, Colors.black],
  ['記録中断', Icon(Icons.pause_circle_outline), Colors.green, Colors.white],
  ['試合終了', Icon(Icons.stop_circle_outlined), Colors.green, Colors.white],
];

// Result
final resultDetailIcon = [
  Icon(Icons.group),
  Icon(Icons.content_paste),
  Icon(Icons.group),
];

final resultDetailText = Text('ランニングスコア');
