import 'package:flutter/material.dart';

class ResultUtil {
  static final home = 0;
  static final away = 1;

  static const teamdata = 11;
  static const totaldata = 12;
  static const perioddata = 13;
  static const playerdata = 14;
  static const progressdata = 15;

  static const fieldgoal = 2;
  static const freethrow = 1;

  static const stay = 0;
  static const play = 1;
  static const change = 2;

  static const player = 0;
  static final assistant = 1;
  static final coach = 2;
}

final resultDetailIcon = [
  Icon(Icons.face),
  Icon(Icons.content_paste),
  Icon(Icons.face),
];

final resultDetailText = Text('ランニングスコア');
