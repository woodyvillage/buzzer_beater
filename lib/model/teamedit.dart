import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';
import 'package:buzzer_beater/util/team.dart';

List<FormDto> buildTeamFormValue(TeamDto _team) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < teams.length; i++) {
    if (teams[i][teamDefault1] is Color) {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][teamIcon]
        ..value = teams[i][teamTitle]
        ..color = teams[i][teamDefault1]
        ..border = teams[i][teamDefault2];
      _form.add(_dto);
    } else {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..icon = teams[i][teamIcon]
        ..hint = teams[i][teamHint]
        ..value = teams[i][teamTitle];
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
    _form[1].border = Color(_team.majormain);
    _form[1].color = Color(_team.majorshade);
    _form[2].border = Color(_team.minormain);
    _form[2].color = Color(_team.minorshade);
  }

  return _form;
}

Future<List<S2Choice<String>>> buildSelectListValue() async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  TeamDao _dao = TeamDao();
  List<TeamDto> _dto = await _dao.select(TableUtil.cId);

  for (int i = 0; i < _dto.length; i++) {
    _list.add(
        S2Choice<String>(value: _dto[i].id.toString(), title: _dto[i].name));
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
  _form[0].controller.text == ''
      ? _dto.name = null
      : _dto.name = _form[0].controller.text;
  _form[0].image == null ? _dto.image = null : _dto.image = _form[0].image.path;
  _form[1].border == null
      ? _dto.majormain = null
      : _dto.majormain = _form[1].border.value;
  _form[1].color == null
      ? _dto.majorshade = null
      : _dto.majorshade = _form[1].color.value;
  _form[2].border == null
      ? _dto.minormain = null
      : _dto.minormain = _form[2].border.value;
  _form[2].color == null
      ? _dto.minorshade = null
      : _dto.minorshade = _form[2].color.value;

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null && await _dao.selectDuplicateCount(_dto) > 0) {
    // 重複あり
    return 1;
  }

  if (_dto.id == null) {
    // 新規登録
    await _dao.insert(_dto);
    _bloc.trigger.add(true);

    return 0;
  } else {
    // 更新登録
    await _dao.update(_dto);
    _bloc.trigger.add(true);

    return 0;
  }
}
