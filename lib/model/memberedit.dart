import 'dart:io';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/member.dart';

List<FormDto> buildMemberFormValue(MemberDto _member) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < members.length; i++) {
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..value = members[i][memberTitle];
    _form.add(_dto);
  }
  if (_member != null) {
    _form[0].controller.text = _member.team.toString();
    if (_member.image == null) {
      _form[0].image = null;
    } else {
      _form[0].image = File(_member.image);
    }
    _form[1].controller.text = _member.name;
    _form[2].controller.text = _member.age.toString();
    _form[3].controller.text = _member.regist.toString();
    _form[4].controller.text = _member.number.toString();
  }

  return _form;
}

Future confirmMemberValue(ApplicationBloc _bloc, MemberDto _selected,
    List<FormDto> _form, bool _switch) async {
  MemberDao _dao = MemberDao();
  MemberDto _dto = MemberDto();

  if (_selected != null) {
    _selected.id == null ? _dto.id = null : _dto.id = _selected.id;
  }
  _form[0].controller.text == ''
      ? _dto.team = null
      : _dto.team = int.parse(_form[0].controller.text);
  _form[0].image == null ? _dto.image = null : _dto.image = _form[0].image.path;
  _form[1].controller.text == ''
      ? _dto.name = null
      : _dto.name = _form[1].controller.text;
  _form[2].controller.text == ''
      ? _dto.age = null
      : _dto.age = int.parse(_form[2].controller.text);
  _form[3].controller.text == ''
      ? _dto.regist = null
      : _dto.regist = int.parse(_form[3].controller.text);
  if (_switch) {
    _form[4].controller.text == ''
        ? _dto.number = null
        : _dto.number = int.parse(_form[4].controller.text);
  } else {
    _dto.number = null;
  }

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

Future firstMembnerSupport(List<TeamDto> _team) async {
  MemberDao _dao = MemberDao();
  MemberDto _dto = MemberDto();

  _dto.team = _team[0].id;

  for (int i = 4; i < 12; i++) {
    _dto.name = i.toString() + '番';
    _dto.age = 12;
    _dto.regist = 0;
    _dto.number = i;
    await _dao.insert(_dto);
  }

  _dto.name = '監督';
  _dto.age = 0;
  _dto.regist = 0;
  _dto.number = null;
  await _dao.insert(_dto);

  _dto.name = 'コーチ';
  _dto.age = 0;
  _dto.regist = 0;
  _dto.number = null;
  await _dao.insert(_dto);
}

Future deleteMember(ApplicationBloc _bloc, MemberDto _dto) async {
  MemberDao _dao = MemberDao();
  await _dao.delete(_dto);
  _bloc.trigger.add(true);

  return 0;
}
