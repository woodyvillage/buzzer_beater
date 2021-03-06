import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/dialog.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/util/table.dart';

List<FormDto> buildMemberFormValue(MemberDto _member) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < members.length; i++) {
    bool _boolvalue;
    if (members[i][ApplicationUtil.formDefault] is bool) {
      _boolvalue = members[i][ApplicationUtil.formDefault];
    } else {
      _boolvalue = null;
    }
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..value = members[i][ApplicationUtil.formTitle]
      ..boolvalue = _boolvalue;
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
    _form[3].controller.text =
        _member.jbaid == 0 ? '' : _member.jbaid.toString().padLeft(9, "0");
    _form[4].controller.text = _member.number.toString();
    _form[5].boolvalue = _member.role == ApplicationUtil.player ? true : false;
  }

  return _form;
}

Future<List<S2Choice<String>>> buildMemberListValue() async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  MemberDao _dao = MemberDao();
  List<MemberDto> _dto = await _dao.select(TableUtil.cId);

  for (MemberDto _member in _dto) {
    _list.add(
        S2Choice<String>(value: _member.id.toString(), title: _member.name));
  }

  return _list;
}

Future<List<S2Choice<String>>> buildMemberListValueByTeamId(int _team) async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  MemberDao _dao = MemberDao();
  List<MemberDto> _dto =
      await _dao.selectByTeamId(_team, TableUtil.cId, TableUtil.asc);

  for (MemberDto _member in _dto) {
    _list.add(
        S2Choice<String>(value: _member.id.toString(), title: _member.name));
  }

  return _list;
}

FormDto levelingForm(List<FormDto> _form) {
  if (_form[2].controller.text == null ||
      _form[2].controller.text == 'null' ||
      _form[2].controller.text == '0') {
    _form[2].controller.text = '';
  }
  if (_form[3].controller.text == null ||
      _form[3].controller.text == 'null' ||
      _form[3].controller.text == '0') {
    _form[3].controller.text = '';
  }
  if (_form[4].controller.text == null ||
      _form[4].controller.text == 'null' ||
      _form[4].controller.text == '-1' ||
      _form[4].controller.text == '0') {
    _form[4].controller.text = '';
  }
  if (_form[5].boolvalue) {
    return _form[4];
  } else {
    return _form[1];
  }
}

Future confirmMemberValue(ApplicationBloc _bloc, BuildContext _context,
    MemberDto _selected, List<FormDto> _form) async {
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
      ? _dto.jbaid = null
      : _dto.jbaid = int.parse(_form[3].controller.text);
  if (_form[5].boolvalue) {
    _form[4].controller.text == ''
        ? _dto.number = null
        : _dto.number = int.parse(_form[4].controller.text);
    _dto.delflg = TableUtil.exist;
  } else {
    _dto.number = null;
  }
  _dto.role = _form[5].boolvalue == true
      ? ApplicationUtil.player
      : ApplicationUtil.coach;

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null &&
      await _dao.cntBy(_dto, [TableUtil.cJbaId, TableUtil.cDelFlg],
              [_dto.jbaid, TableUtil.exist]) >
          0) {
    // 重複あり
    return 1;
  }

  if (_dto.id == null) {
    // 新規登録
    await _dao.insert(_dto);
  } else {
    // 更新登録
    List<MemberDto> _old_member = await _dao.selectById(_dto.id);
    if (_old_member[0].jbaid == _dto.jbaid) {
      await _dao.update(_dto);
    } else {
      _old_member[0].delflg = TableUtil.deleted;
      await _dao.update(_old_member[0]);

      RegistDao _regdao = RegistDao();
      List<RegistDto> _regists =
          await _regdao.selectByMemberId(_old_member[0].id);
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

      _dto.id = null;
      _dto.delflg = TableUtil.exist;
      await _dao.insert(_dto);
    }
  }
  _bloc.trigger.add(true);

  return 0;
}

Future firstMemberSupport(List<TeamDto> _team) async {
  MemberDao _dao = MemberDao();
  MemberDto _dto = MemberDto();

  _dto.team = _team[0].id;

  for (int i = 4; i <= 18; i++) {
    _dto.role = ApplicationUtil.player;
    _dto.name = i.toString() + '番';
    _dto.age = 12;
    _dto.jbaid = i + (i * 1234) + (i * 12345678);
    _dto.number = i + 20;
    _dto.delflg = TableUtil.exist;
    await _dao.insert(_dto);
  }

  _dto.role = ApplicationUtil.coach;
  _dto.name = '監督';
  _dto.age = 40;
  _dto.jbaid = 13 + (13 * 1234) + (13 * 12345678);
  _dto.number = null;
  _dto.delflg = TableUtil.exist;
  await _dao.insert(_dto);

  _dto.role = ApplicationUtil.coach;
  _dto.name = 'コーチ';
  _dto.age = 30;
  _dto.jbaid = 14 + (14 * 1234) + (14 * 12345678);
  _dto.number = null;
  _dto.delflg = TableUtil.exist;
  await _dao.insert(_dto);
}

Future deleteMember(
    ApplicationBloc _bloc, BuildContext _context, MemberDto _dto) async {
  int _state = 0;
  RegistDao _regdao = RegistDao();
  List<RegistDto> _regists = await _regdao.selectByMemberId(_dto.id);
  for (RegistDto _regist in _regists) {
    MatchDao _mdao = MatchDao();
    List<MatchDto> _matchs = await _mdao.selectByRosterId(_regist.roster);
    for (MatchDto _match in _matchs) {
      _state += _match.status;
    }
    if (_state != _matchs.length * ApplicationUtil.definite) {
      return 1;
    }
  }

  bool _result = await showMessageDialog(
    context: _context,
    title: messages[SettingUtil.messageMemberDelete][0],
    value: messages[SettingUtil.messageMemberDelete][1],
  );
  if (_result) {
    MemberDao _mdao = MemberDao();
    _dto.delflg = TableUtil.deleted;
    await _mdao.update(_dto);

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

  _bloc.trigger.add(true);
  return 0;
}
