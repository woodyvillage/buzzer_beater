import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/util/member.dart';

List<FormDto> buildMemberFormValue(MemberDto _member) {
  List<FormDto> _form = List<FormDto>();

  for (int i = 0; i < members.length; i++) {
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..icon = members[i][memberIcon]
      ..value = members[i][memberTitle];
    _form.add(_dto);
  }
  return _form;
}

Future confirmMemberValue(ApplicationBloc _bloc, MemberDto _selected, List<FormDto> _form) async {
  MemberDao _dao = MemberDao();
  MemberDto _dto = MemberDto();

  if (_selected != null) {
    _selected.id == null ? _dto.id = null : _dto.id = _selected.id;
  }
  _form[0].controller.text == '' ? _dto.team = null : _dto.team = int.parse(_form[0].controller.text);
  _form[1].controller.text == '' ? _dto.name = null : _dto.name = _form[1].controller.text;
  _form[2].controller.text == '' ? _dto.age = null : _dto.age = int.parse(_form[2].controller.text);
  _form[3].controller.text == '' ? _dto.regist = null : _dto.regist = int.parse(_form[3].controller.text);

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null && await _dao.selectCount(_dto) > 0) {
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