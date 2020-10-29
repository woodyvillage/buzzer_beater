import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/memberedit.dart';
import 'package:buzzer_beater/model/rosteredit.dart';
import 'package:buzzer_beater/util/table.dart';
import 'package:buzzer_beater/util/team.dart';

List<FormDto> buildTeamFormValue(TeamDto _team) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < teams.length; i++) {
    if (teams[i][TeamUtil.teamMainColor] is Color) {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][TeamUtil.teamIcon]
        ..value = teams[i][TeamUtil.teamTitle]
        ..mainColor = teams[i][TeamUtil.teamMainColor]
        ..edgeColor = teams[i][TeamUtil.teamEdgeColor];
      _form.add(_dto);
    } else {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][TeamUtil.teamIcon]
        ..hint = teams[i][TeamUtil.teamHint]
        ..value = teams[i][TeamUtil.teamTitle];
      _form.add(_dto);
    }
  }
  if (_team != null) {
    _form[0].controller.text = _team.name;
    if (_team.image == null) {
      _form[0].image = null;
    } else {
      _form[0].image = File(_team.image);
    }
    _form[1].mainColor = Color(_team.homeMain);
    _form[1].edgeColor = Color(_team.homeEdge);
    _form[2].mainColor = Color(_team.awayMain);
    _form[2].edgeColor = Color(_team.awayEdge);
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

Future confirmTeamValue(ApplicationBloc _bloc, TeamDto _selected,
    List<FormDto> _form, bool _isSupport) async {
  TeamDao _dao = TeamDao();
  TeamDto _dto = TeamDto();

  if (_selected != null) {
    _selected.id == null ? _dto.id = null : _dto.id = _selected.id;
  }
  _form[0].controller.text == ''
      ? _dto.name = null
      : _dto.name = _form[0].controller.text;
  _form[0].image == null ? _dto.image = null : _dto.image = _form[0].image.path;
  _form[1].mainColor == null
      ? _dto.homeMain = null
      : _dto.homeMain = _form[1].mainColor.value;
  _form[1].edgeColor == null
      ? _dto.homeEdge = null
      : _dto.homeEdge = _form[1].edgeColor.value;
  _form[2].mainColor == null
      ? _dto.awayMain = null
      : _dto.awayMain = _form[2].mainColor.value;
  _form[2].edgeColor == null
      ? _dto.awayEdge = null
      : _dto.awayEdge = _form[2].edgeColor.value;

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null &&
      await _dao.duplicateCount(_dto, [TableUtil.cName], [_dto.name]) > 0) {
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

  if (_isSupport) {
    List<TeamDto> _team = await _dao.selectByName(_dto.name);
    await firstMemberSupport(_team);
    await firstRosterSupport(_team);
  }

  return 0;
}

Future deleteTeam(ApplicationBloc _bloc, TeamDto _dto) async {
  TeamDao _dao = TeamDao();
  await _dao.delete(_dto);
  _bloc.trigger.add(true);

  return 0;
}
