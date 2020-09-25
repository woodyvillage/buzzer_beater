import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

final teams = [
  [Icon(MaterialCommunityIcons.basketball), 'チーム名称', null, '', '', false],
  [Icon(MaterialCommunityIcons.tshirt_crew), 'ユニフォームカラー１', null, Colors.red[800], Colors.red, false],
  [Icon(MaterialCommunityIcons.tshirt_crew_outline), 'ユニフォームカラー２', null, Colors.white, Colors.grey, false],
];
final teamIcon = 0;
final teamTitle = 1;
final teamHint = 2;
final teamDefault1 = 3;
final teamDefault2 = 4;
final teamCaption = 5;

final formIcon = [
  Icon(Icons.check_circle),
  Icon(Icons.cancel),
];

final formText = [
  Text('追加'),
  Text('取消'),
];

final formSubmit = 0;
final formCancel = 1;
