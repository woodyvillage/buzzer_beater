// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';
import 'package:intl/intl.dart';

// import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';
// import 'package:buzzer_beater/util/team.dart';

// import 'package:buzzer_beater/dto/match.dart';

void test() async {
  TeamDao _tdao = TeamDao();
  TeamDto _tdto = TeamDto();

  // List<TeamDto> _team = await _tdao.selectById(1);
  // for (int i = 0; i < _team.length; i++) {
  // _team[i].name = '東京ダブルドリブル';
  // await _tdao.update(_team[i]);
  // }

  // _team = await _tdao.selectById(2);
  // for (int i = 0; i < _team.length; i++) {
  // _team[i].name = '神奈川アンクルブレイク';
  // await _tdao.update(_team[i]);
  // }

  // MatchDao _dao = MatchDao();
  // MatchDto _dto = MatchDto();

  // var _dateFormat = DateFormat('yyyy年MM月dd日(E) HH:mm', 'ja_JP');
  // var _date = _dateFormat.format(DateTime.now());

  // _dto.name = '県大会予選';
  // _dto.date = _date;
  // _dto.hometeam = 1;
  // _dto.awayteam = 2;

  //   await _dao.insert(_dto);

  // MatchDao _dao = MatchDao();
  // MatchDto _dto = MatchDto();

  // List<MatchDto> _match = await _dao.select(TableUtil.cDate);

  // for (int i = 0; i < _match.length; i++) {
  // _match[i].place = '体育館';
  // await _dao.update(_match[i]);
  // }

  // PeriodDao _dao = PeriodDao();
  // PeriodDto _dto = PeriodDto();

  // _dto.match = 1;
  // _dto.team = 1;
  // _dto.number = 1;
  // _dto.score = 8;
  //   await _dao.insert(_dto);
  // _dto.number = 2;
  // _dto.score = 6;
  //   await _dao.insert(_dto);
  // _dto.number = 3;
  // _dto.score = 12;
  //   await _dao.insert(_dto);
  // _dto.number = 4;
  // _dto.score = 9;
  //   await _dao.insert(_dto);

  // _dto.match = 1;
  // _dto.team = 2;
  // _dto.number = 1;
  // _dto.score = 12;
  //   await _dao.insert(_dto);
  // _dto.number = 2;
  // _dto.score = 12;
  //   await _dao.insert(_dto);
  // _dto.number = 3;
  // _dto.score = 8;
  //   await _dao.insert(_dto);
  // _dto.number = 4;
  // _dto.score = 7;
  //   await _dao.insert(_dto);

}
