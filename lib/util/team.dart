import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final teams = [
  [Icon(MaterialCommunityIcons.basketball), 'チーム名称', null, '', ''],
  [
    Icon(MaterialCommunityIcons.tshirt_crew),
    'ユニフォームカラー１',
    null,
    Colors.red[800],
    Colors.red
  ],
  [
    Icon(MaterialCommunityIcons.tshirt_crew_outline),
    'ユニフォームカラー２',
    null,
    Colors.white,
    Colors.grey
  ],
];
final teamIcon = 0;
final teamTitle = 1;
final teamHint = 2;
final teamDefault1 = 3;
final teamDefault2 = 4;
