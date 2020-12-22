import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/dialog.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/memberedit.dart';
import 'package:buzzer_beater/model/rosteredit.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/util/table.dart';

List<FormDto> buildTeamFormValue(TeamDto _team) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < teams.length; i++) {
    if (teams[i][ApplicationUtil.functionColor] is Color) {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][ApplicationUtil.functionIcon]
        ..value = teams[i][ApplicationUtil.functionTitle]
        ..mainColor = teams[i][ApplicationUtil.functionColor]
        ..edgeColor = teams[i][ApplicationUtil.functionEdge];
      _form.add(_dto);
    } else if (teams[i][ApplicationUtil.functionBool] is bool) {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][ApplicationUtil.functionIcon]
        ..value = teams[i][ApplicationUtil.functionTitle]
        ..boolvalue = teams[i][ApplicationUtil.functionBool];
      _form.add(_dto);
    } else {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][ApplicationUtil.functionIcon]
        ..value = teams[i][ApplicationUtil.functionTitle]
        ..boolvalue = teams[i][ApplicationUtil.functionBool];
      _form.add(_dto);
    }
  }
  if (_team != null) {
    _form[0].controller.text = _team.name;
    _form[0].image = _team.image == null ? null : File(_team.image);
    _form[1].mainColor = Color(_team.homeMain);
    _form[1].edgeColor = Color(_team.homeEdge);
    _form[2].mainColor = Color(_team.awayMain);
    _form[2].edgeColor = Color(_team.awayEdge);
    _form[3].boolvalue = _team.owner == ApplicationUtil.owner ? true : false;
  }

  return _form;
}

Future<List<S2Choice<String>>> buildTeamListValue() async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  TeamDao _dao = TeamDao();
  List<TeamDto> _dto = await _dao.select(TableUtil.cId);

  for (TeamDto _team in _dto) {
    _list.add(S2Choice<String>(value: _team.id.toString(), title: _team.name));
  }

  return _list;
}

Future<List<S2Choice<String>>> buildTeamListValueById(int _index) async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  TeamDao _dao = TeamDao();
  List<TeamDto> _dto = await _dao.selectById(_index);

  for (TeamDto _team in _dto) {
    _list.add(S2Choice<String>(value: _team.id.toString(), title: _team.name));
  }

  return _list;
}

Future confirmTeamValue(
    ApplicationBloc _bloc, TeamDto _selected, List<FormDto> _form) async {
  TeamDao _dao = TeamDao();
  TeamDto _dto = TeamDto();

  if (_selected != null) {
    _selected.id == null ? _dto.id = null : _dto.id = _selected.id;
  }
  _dto.name = _form[0].controller.text == '' ? null : _form[0].controller.text;
  _dto.image = _form[0].image == null ? null : _form[0].image.path;
  _dto.homeMain = _form[1].mainColor == null ? null : _form[1].mainColor.value;
  _dto.homeEdge = _form[1].edgeColor == null ? null : _form[1].edgeColor.value;
  _dto.awayMain = _form[2].mainColor == null ? null : _form[2].mainColor.value;
  _dto.awayEdge = _form[2].edgeColor == null ? null : _form[2].edgeColor.value;
  _dto.owner = _form[3].boolvalue == true
      ? ApplicationUtil.owner
      : ApplicationUtil.other;
  _dto.delflg = TableUtil.exist;

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null &&
      await _dao.countUnique(TableUtil.cName, _dto.name) > 0) {
    // 重複あり
    return 1;
  }

  if (_dto.id == null) {
    // 新規登録
    await _dao.insert(_dto);
  } else {
    // 更新登録
    await _dao.update(_dto);
  }
  _bloc.trigger.add(true);

  if (_form[4].boolvalue) {
    List<TeamDto> _team = await _dao.selectByName(_dto.name);
    await firstMemberSupport(_team);
    await firstRosterSupport(_team);
  }

  return 0;
}

Future deleteTeam(
    ApplicationBloc _bloc, BuildContext _context, TeamDto _dto) async {
  int _state = 0;
  RosterDao _rosdao = RosterDao();
  List<RosterDto> _rosters =
      await _rosdao.selectByTeamId(_dto.id, [TableUtil.cName], [TableUtil.asc]);
  for (RosterDto _roster in _rosters) {
    MatchDao _mdao = MatchDao();
    List<MatchDto> _matchs = await _mdao.selectByRosterId(_roster.id);
    for (MatchDto _match in _matchs) {
      _state += _match.status;
    }
    if (_state != _matchs.length * ApplicationUtil.definite) {
      return 1;
    }
  }

  TeamDao _dao = TeamDao();
  MemberDao _mdao = MemberDao();
  List<MemberDto> _members =
      await _mdao.selectByTeamId(_dto.id, TableUtil.cAge, TableUtil.desc);

  bool _result = await showMessageDialog(
    context: _context,
    title: messages[SettingUtil.messageTeamDelete][0],
    value: messages[SettingUtil.messageTeamDelete][1],
  );

  if (_result) {
    _dto.delflg = TableUtil.deleted;
    await _dao.update(_dto);

    for (MemberDto _member in _members) {
      _member.delflg = TableUtil.deleted;
      await _mdao.update(_member);

      RegistDao _regdao = RegistDao();
      List<RegistDto> _regists = await _regdao.selectByMemberId(_member.id);
      for (RegistDto _regist in _regists) {
        _regist.delflg = TableUtil.deleted;
        await _regdao.update(_regist);

        List<RegistDto> _exists = await _regdao
            .selectByRosterId(_regist.roster, [TableUtil.cId], [TableUtil.asc]);
        if (_exists.isEmpty) {
          RosterDao _rosdao = RosterDao();
          List<RosterDto> _rosters = await _rosdao.selectById(_regist.roster);
          _rosters[0].delflg = TableUtil.deleted;
          await _rosdao.update(_rosters[0]);
        }
      }
    }
  }

  _bloc.trigger.add(true);
  return 0;
}
