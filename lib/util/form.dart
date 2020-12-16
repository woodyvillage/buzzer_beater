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
  [
    'チーム名称',
    null,
    null,
    null,
  ],
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
  ['マンツーマン', null, Colors.purple, Colors.white],
  ['なし', null, Colors.amber, Colors.black],
  ['あり', null, Colors.amber, Colors.black],
  ['コーチ', null, Colors.amber, Colors.black],
  ['ベンチ', null, Colors.amber, Colors.black],
  ['記録中断', Icon(Icons.pause_circle_outline), Colors.green, Colors.white],
  ['試合終了', Icon(Icons.stop_circle_outlined), Colors.green, Colors.white],
];

// Result
final resultDetailIcon = [
  Icon(Icons.group),
  Icon(Icons.content_paste),
  Icon(Icons.group),
];

String resultDetailText = 'ランニングスコア';

final roster_questions = [
  'ロースターってなに？',
  'すでに出来ているロースターに別のメンバーを追加したいのですが？',
  'ロースターの名前を変えたいのですが？',
];

final roster_answers = [
  '試合に出場できる最大１５名の登録選手のこと言います。',
  '一度登録を終えたロースターにメンバーを追加することはできません。新たに別のロースターとして登録してください。',
  '登録名は変更できません。同じメンバーで、別のロースターとして新しく登録してください。',
];

final match_questions = [
  'メンバーはどうやって指定するの？',
  'メンバーは誰でもいいの？',
  'メンバーを選んだらどうするの？',
  'タイムアウトはどうするの？',
  'メンバー交代はどうするの？',
  'シュートはどうやって記録する？',
  'ファウルはどうやって記録する？',
  'ピリオドが終わったら？',
  '次のピリオドのメンバーはどうやって指定するの？',
  'ちょっと他の画面に戻りたいんだけど？',
];

final match_answers = [
  '左右の７枚のパネルを長押しして選びます。',
  '選手５人とコーチ、アシスタントコーチにしてください。',
  '試合が始まったら、1Qを長押ししましょう。',
  'タイムアウトを長押しです。',
  'OUTする選手を先に選んでメンバー交代を長押しします。',
  'シュートを入れた選手を選んで、「フィールドゴール」「フリースロー」を長押しします。「オウンゴール」の場合は、入れてしまった側の選手の誰でも構いません。',
  'ファウルをした選手を選んでから、ファールの種類を選びます。ファールによっては、フリースローの有無やベンチ、コーチのどちらかなどオプションを求められます。',
  '終了するピリオドを長押しします。',
  '次のピリオドを始めるまでの間に、選手を選びなおしてください。',
  '記録中段を押すと、現在の内容を保存したまま戻ることができます。',
];

final messages = [
  ['チームの更新', 'チームを削除しても、試合結果として記録されたチーム名はそのまま残ります。'],
  ['チームの削除', 'チームを削除しても、試合結果として記録されたチーム名はそのまま残ります。'],
  ['メンバーの更新', 'メンバーを削除しても、試合結果として記録された氏名等はそのまま残ります。'],
  ['メンバーの削除', 'メンバーを削除しても、試合結果として記録された氏名等はそのまま残ります。'],
  ['ロースターの更新', 'メンバーを削除しても、試合結果として記録された氏名等はそのまま残ります。'],
  ['ロースターの削除', 'メンバーを削除しても、試合結果として記録された氏名等はそのまま残ります。'],
];
