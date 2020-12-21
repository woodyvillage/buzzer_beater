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
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/util/table.dart';

Future<List<FormDto>> buildRosterFormValue(PlayerDto _member) async {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < rosters.length; i++) {
    bool _boolvalue;
    if (rosters[i][ApplicationUtil.formDefault] is bool) {
      _boolvalue = rosters[i][ApplicationUtil.formDefault];
    } else {
      _boolvalue = null;
    }
    var _dto = FormDto()
      ..node = FocusNode()
      ..controller = TextEditingController()
      ..value = rosters[i][ApplicationUtil.formTitle]
      ..hint = rosters[i][ApplicationUtil.formDefault] == 0
          ? ''
          : rosters[i][ApplicationUtil.formDefault].toString()
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
    _form[2].boolvalue =
        _member.captain == ApplicationUtil.captain ? true : false;
    _form[3].boolvalue = _member.role == ApplicationUtil.player ? true : false;
    if (_member.role == ApplicationUtil.player) {
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

Future<List<S2Choice<String>>> buildMemberListValueByRosterId(
    int _roster) async {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  RegistDao _dao = RegistDao();
  List<RegistDto> _dto = await _dao.selectByRosterId(_roster,
      [TableUtil.cSort, TableUtil.cNumber], [TableUtil.asc, TableUtil.asc]);

  for (RegistDto _regist in _dto) {
    MemberDao _mdao = MemberDao();
    List<MemberDto> _member = await _mdao.selectById(_regist.member);

    if (_regist.role > 0) {
      _list.add(S2Choice<String>(
          value: _regist.member.toString(), title: 'コーチ ' + _member[0].name));
    } else {
      _list.add(S2Choice<String>(
          value: _regist.member.toString(),
          title: _regist.number.toString() + '番 ' + _member[0].name));
    }
  }

  return _list;
}

Future confirmRosterValue(ApplicationBloc _bloc, BuildContext _context,
    List<FormDto> _form, bool _isEdit) async {
  if (_form[0].controller.text.isEmpty || _form[1].controller.text == '') {
    // 必須項目未入力
    return -1;
  }

  int _result = _isEdit == true
      ? await confirmRosterValueUpdate(_bloc, _context, _form)
      : await confirmRosterValueInsert(_bloc, _context, _form);
  _bloc.trigger.add(true);

  return _result;
}

Future confirmRosterValueInsert(
    ApplicationBloc _bloc, BuildContext _context, List<FormDto> _form) async {
  RosterDao _rosdao = RosterDao();
  RosterDto _roster = RosterDto();
  RegistDao _regdao = RegistDao();
  RegistDto _regist = RegistDto();
  MemberDao _mdao = MemberDao();

  var _checker = <String>[];
  int _memberCount = 0;
  for (int i = 2; i < _form.length; i = i + 2) {
    if (_form[i].controller.text.isNotEmpty &&
        _form[i + 1].controller.text.isNotEmpty) {
      _checker.add(_form[i].controller.text);
      _memberCount++;
    }
  }

  int _rosterCount = await _rosdao.cntBy(
    _roster,
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

  _roster.team = int.parse(_form[0].controller.text);
  _roster.name = _form[1].controller.text;
  if (_rosterCount == 0) {
    await _rosdao.insert(_roster);
  }

  List<RosterDto> _rosters =
      await _rosdao.selectByTeamIdName(_roster.team, _roster.name);
  for (int i = 2; i < _form.length; i = i + 2) {
    if (_form[i].controller.text != '') {
      List<MemberDto> _member =
          await _mdao.selectById(int.parse(_form[i].controller.text));

      if (_member.isNotEmpty) {
        _regist.team = int.parse(_form[0].controller.text);
        _regist.roster = _rosters[0].id;
        _form[i].controller.text.isEmpty
            ? _regist.member = null
            : _regist.member = int.parse(_form[i].controller.text);
        _form[i + 1].controller.text.isEmpty
            ? _regist.number = null
            : _regist.number = int.parse(_form[i + 1].controller.text);
        _regist.role = _member[0].role;
        _regist.captain = _form[i].boolvalue == true
            ? ApplicationUtil.captain
            : ApplicationUtil.player;
        _regist.sort = _member[0].role == ApplicationUtil.player
            ? ApplicationUtil.player
            : ApplicationUtil.coach;
        _regist.ball = null;
        _regist.foul = null;
        _regist.delflg = TableUtil.exist;
      }

      if (_regist.member != null) {
        await _regdao.insert(_regist);
      }
    }
  }

  return 0;
}

Future confirmRosterValueUpdate(
    ApplicationBloc _bloc, BuildContext _context, List<FormDto> _form) async {
  RosterDao _rosdao = RosterDao();
  RegistDao _regdao = RegistDao();
  RegistDto _regist = RegistDto();

  MemberDao _mdao = MemberDao();

  List<RosterDto> _roster = await _rosdao.selectByTeamIdName(
      int.parse(_form[0].controller.text), _form[1].controller.text);
  List<RegistDto> _old_regist = await _regdao.selectByRosterMember(
      _roster[0].id, int.parse(_form[2].hint));

  _old_regist[0].delflg = TableUtil.deleted;
  await _regdao.update(_old_regist[0]);

  List<MemberDto> _member =
      await _mdao.selectById(int.parse(_form[2].controller.text));
  _regist.team = int.parse(_form[0].controller.text);
  _regist.roster = _roster[0].id;
  _form[2].controller.text.isEmpty
      ? _regist.member = null
      : _regist.member = int.parse(_form[2].controller.text);
  _form[3].controller.text.isEmpty
      ? _regist.number = null
      : _regist.number = int.parse(_form[3].controller.text);
  _regist.role = _member[0].role;
  _regist.captain = _form[2].boolvalue == true
      ? ApplicationUtil.captain
      : ApplicationUtil.player;
  _regist.sort = _member[0].role == ApplicationUtil.player
      ? ApplicationUtil.player
      : ApplicationUtil.coach;
  _regist.ball = null;
  _regist.foul = null;
  _regist.delflg = TableUtil.exist;
  await _regdao.insert(_regist);

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
    if (_member.role == ApplicationUtil.player) {
      _rdto.number = i;
    } else {
      _rdto.number = null;
    }
    if (i == 19) {
      _rdto.role = ApplicationUtil.coach;
    } else if (i == 20) {
      _rdto.role = ApplicationUtil.assistant;
    } else {
      _rdto.role = ApplicationUtil.player;
    }
    _rdto.captain = i == 4 ? 1 : null;
    _rdto.sort = _member.role;
    _rdto.delflg = TableUtil.exist;
    await _rdao.insert(_rdto);
    i++;
  }
}

Future deleteRoster(
    ApplicationBloc _bloc, BuildContext _context, PlayerDto _player) async {
  int _state = 0;
  MatchDao _mdao = MatchDao();
  List<MatchDto> _matchs = await _mdao.selectByRosterId(_player.roster);
  for (MatchDto _match in _matchs) {
    _state += _match.status;
  }
  if (_state != _matchs.length * ApplicationUtil.definite) {
    return 1;
  }

  bool _result = await showMessageDialog(
    context: _context,
    title: messages[SettingUtil.messageRosterDelete][0],
    value: messages[SettingUtil.messageRosterDelete][1],
  );
  if (_result) {
    RegistDao _regdao = RegistDao();
    List<RegistDto> _regists =
        await _regdao.selectByRosterMember(_player.roster, _player.member);
    _regists[0].delflg = TableUtil.deleted;
    await _regdao.update(_regists[0]);

    List<RegistDto> _exists = await _regdao
        .selectByRosterId(_player.roster, [TableUtil.cId], [TableUtil.asc]);
    if (_exists.isEmpty) {
      RosterDao _rosdao = RosterDao();
      List<RosterDto> _rosters = await _rosdao.selectById(_regists[0].roster);
      _rosters[0].delflg = TableUtil.deleted;
      await _rosdao.update(_rosters[0]);
    }
  }

  _bloc.trigger.add(true);
  return 0;
}
