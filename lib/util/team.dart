import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final teams = [
  [Icon(MaterialCommunityIcons.basketball), 'チーム名称', null, '', ''],
  [
    Icon(MaterialCommunityIcons.tshirt_crew_outline),
    'ホームカラー（淡）',
    null,
    Colors.white,
    Colors.grey,
  ],
  [
    Icon(MaterialCommunityIcons.tshirt_crew),
    'ビジターカラー（濃）',
    null,
    Colors.blue,
    Colors.lightBlue[100],
  ],
];

class TeamUtil {
  static final teamIcon = 0;
  static final teamTitle = 1;
  static final teamHint = 2;
  static final teamMainColor = 3;
  static final teamEdgeColor = 4;

  static final homeColor = 0;
  static final awayColor = 1;
  static final mainColor = 2;
  static final edgeColor = 3;
}
