import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/record.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/roster.dart';
import 'package:buzzer_beater/util/table.dart';

Future<List<FormDto>> buildRosterFormValue(PlayerDto _member) async {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < rosters.length; i++) {
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..value = rosters[i][RosterUtil.memberTitle]
      ..hint = rosters[i][RosterUtil.memberDefault] == 0
          ? ''
          : rosters[i][RosterUtil.memberDefault].toString();
    _form.add(_dto);
  }

  if (_member != null) {
    RosterDao _dao = RosterDao();
    List<RosterDto> _roster = await _dao.selectById(_member.roster);

    _form[0].controller.text = _member.team.toString();
    _form[1].controller.text = _roster[0].name;
    _form[2].controller.text = _member.member.toString();
    _form[2].hint = _member.member.toString();
    _form[3].boolvalue = _member.role == RosterUtil.player ? true : false;
    if (_member.role == RosterUtil.player) {
      _form[3].controller.text = _member.number.toString();
    }
  }

  return _form;
}

Future confirmRosterValue(
    ApplicationBloc _bloc, List<FormDto> _form, bool _isEdit) async {
  RosterDao _dao = RosterDao();
  RosterDto _dto = RosterDto();
  RecordDao _rdao = RecordDao();
  RecordDto _rdto = RecordDto();

  if (_form[0].controller.text.isEmpty || _form[1].controller.text == '') {
    if (!_dto.isComplete()) {
      // 必須項目未入力
      return -1;
    }
  }

  var _checker = <String>[];
  if (!_isEdit) {
    int _memberCount = 0;
    for (int i = 2; i < _form.length; i = i + 2) {
      if (_form[i].controller.text.isNotEmpty &&
          _form[i + 1].controller.text.isNotEmpty) {
        _checker.add(_form[i].controller.text);
        _memberCount++;
      }
    }

    int _rosterCount = await _dao.duplicateCount(
      _dto,
      [TableUtil.cTeam, TableUtil.cName],
      [int.parse(_form[0].controller.text), _form[1].controller.text],
    );

    if (_rosterCount == 0 && _memberCount < 8) {
      // 最低人数未満
      print(_memberCount);
      return -2;
    }
    if (_rosterCount == 0 && _memberCount != _checker.toSet().toList().length) {
      // 重複あり
      return 1;
    }

    _dto.team = int.parse(_form[0].controller.text);
    _dto.name = _form[1].controller.text;
    if (_rosterCount == 0) {
      await _dao.insert(_dto);
    }

    List<RosterDto> _roster = await _dao.selectByName(_dto.team, _dto.name);
    for (int i = 2; i < _form.length; i = i + 2) {
      _rdto.team = int.parse(_form[0].controller.text);
      _rdto.roster = _roster[0].id;
      _form[i].controller.text.isEmpty
          ? _rdto.member = null
          : _rdto.member = int.parse(_form[i].controller.text);
      _form[i + 1].controller.text.isEmpty
          ? _rdto.number = null
          : _rdto.number = int.parse(_form[i + 1].controller.text);
      if (_rdto.member != null) {
        await _rdao.insert(_rdto);
      }
    }
  } else {
    List<RosterDto> _roster = await _dao.selectByName(
        int.parse(_form[0].controller.text), _form[1].controller.text);
    List<RecordDto> _record =
        await _rdao.selectByMemberId(_roster[0].id, int.parse(_form[2].hint));

    _record[0].member = int.parse(_form[2].controller.text);
    _record[0].number = int.parse(_form[3].controller.text);
    if (_record[0].member != null) {
      await _rdao.update(_record[0]);
    }
  }
  _bloc.trigger.add(true);

  return 0;
}

Future firstRosterSupport(List<TeamDto> _team) async {
  RosterDao _dao = RosterDao();
  RosterDto _dto = RosterDto();

  _dto.team = _team[0].id;
  _dto.name = '暫定ロースター';
  await _dao.insert(_dto);

  List<RosterDto> _roster = await _dao.selectByName(_team[0].id, _dto.name);

  RecordDao _rdao = RecordDao();
  RecordDto _rdto = RecordDto();

  for (int i = 4; i < 14; i++) {
    _rdto.team = _team[0].id;
    _rdto.roster = _roster[0].id;
    _rdto.member = i - 3;
    if (i > 11) {
      _rdto.number = null;
    } else {
      _rdto.number = i;
    }
    await _rdao.insert(_rdto);
  }
}

Future deleteRoster(ApplicationBloc _bloc, PlayerDto _player) async {
  RecordDao _dao = RecordDao();
  List<RecordDto> _dto =
      await _dao.selectByMemberId(_player.roster, _player.member);
  await _dao.delete(_dto[0]);
  _bloc.trigger.add(true);

  return 0;
}
