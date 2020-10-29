import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/roster.dart';
import 'package:buzzer_beater/util/table.dart';

Future<List<FormDto>> buildRosterFormValue(PlayerDto _member) async {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < rosters.length; i++) {
    bool _boolvalue;
    if (rosters[i][RosterUtil.memberDefault] is bool) {
      _boolvalue = rosters[i][RosterUtil.memberDefault];
    } else {
      _boolvalue = null;
    }
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..value = rosters[i][RosterUtil.memberTitle]
      ..hint = rosters[i][RosterUtil.memberDefault] == 0
          ? ''
          : rosters[i][RosterUtil.memberDefault].toString()
      ..boolvalue = _boolvalue;
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

Future<List<S2Choice<String>>> buildRosterListValue() async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  RosterDao _rdao = RosterDao();
  List<RosterDto> _rdto = await _rdao.select(TableUtil.cId);

  for (RosterDto _roster in _rdto) {
    _list.add(S2Choice<String>(
      value: _roster.id.toString(),
      title: _roster.name,
    ));
  }

  return _list;
}

Future<List<S2Choice<String>>> buildRosterListValueByTeamId(int _value) async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  RosterDao _rdao = RosterDao();
  List<RosterDto> _rdto =
      await _rdao.selectByTeamId(_value, [TableUtil.cName], [TableUtil.asc]);

  for (RosterDto _roster in _rdto) {
    _list.add(S2Choice<String>(
      value: _roster.id.toString(),
      title: _roster.name,
    ));
  }

  return _list;
}

Future confirmRosterValue(
    ApplicationBloc _bloc, List<FormDto> _form, bool _isEdit) async {
  RosterDao _dao = RosterDao();
  RosterDto _dto = RosterDto();
  RegistDao _rdao = RegistDao();
  RegistDto _rdto = RegistDto();

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

    MemberDao _mdao = MemberDao();
    List<RosterDto> _roster =
        await _dao.selectByTeamIdName(_dto.team, _dto.name);
    for (int i = 2; i < _form.length; i = i + 2) {
      if (_form[i].controller.text != '') {
        List<MemberDto> _member =
            await _mdao.selectById(int.parse(_form[i].controller.text));

        if (_member.isNotEmpty) {
          _rdto.team = int.parse(_form[0].controller.text);
          _rdto.roster = _roster[0].id;
          _form[i].controller.text.isEmpty
              ? _rdto.member = null
              : _rdto.member = int.parse(_form[i].controller.text);
          _form[i + 1].controller.text.isEmpty
              ? _rdto.number = null
              : _rdto.number = int.parse(_form[i + 1].controller.text);
          _rdto.role = _member[0].role;
          _rdto.sort = _member[0].role == RosterUtil.player
              ? RosterUtil.player
              : RosterUtil.coach;
        }

        if (_rdto.member != null) {
          await _rdao.insert(_rdto);
        }
      }
    }
  } else {
    List<RosterDto> _roster = await _dao.selectByTeamIdName(
        int.parse(_form[0].controller.text), _form[1].controller.text);
    List<RegistDto> _record = await _rdao.selectByRosterMember(
        _roster[0].id, int.parse(_form[2].hint));

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

  List<RosterDto> _roster =
      await _dao.selectByTeamIdName(_team[0].id, _dto.name);

  RegistDao _rdao = RegistDao();
  RegistDto _rdto = RegistDto();

  MemberDao _mdao = MemberDao();
  List<MemberDto> _members =
      await _mdao.selectByTeamId(_team[0].id, TableUtil.cId, TableUtil.asc);

  int i = 4;
  for (MemberDto _member in _members) {
    _rdto.team = _team[0].id;
    _rdto.roster = _roster[0].id;
    _rdto.member = _member.id;
    if (_member.role == RosterUtil.player) {
      _rdto.number = i;
    } else {
      _rdto.number = null;
    }
    if (i == 12) {
      _rdto.role = RosterUtil.coach;
    } else if (i == 13) {
      _rdto.role = RosterUtil.assistant;
    } else {
      _rdto.role = RosterUtil.player;
    }
    _rdto.sort = _member.role;
    await _rdao.insert(_rdto);
    i++;
  }
}

Future deleteRoster(ApplicationBloc _bloc, PlayerDto _player) async {
  RegistDao _dao = RegistDao();
  List<RegistDto> _dto =
      await _dao.selectByRosterMember(_player.roster, _player.member);
  await _dao.delete(_dto[0]);
  _bloc.trigger.add(true);

  return 0;
}
