import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/dialog.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/record.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dao/result.dart';
import 'package:buzzer_beater/dao/score.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/table.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

List<FormDto> buildMatchFormValue(MatchDto _member) {
  List<FormDto> _form = <FormDto>[];

  for (int i = 0; i < matchs.length; i++) {
    if (matchs[i][ApplicationUtil.formDefault] is bool) {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..hint = matchs[i][ApplicationUtil.formHint]
        ..value = matchs[i][ApplicationUtil.formTitle]
        ..boolvalue = matchs[i][ApplicationUtil.formDefault];
      _form.add(_dto);
    } else {
      var _dto = FormDto()
        ..node = FocusNode()
        ..controller = TextEditingController()
        ..hint = matchs[i][ApplicationUtil.formHint]
        ..value = matchs[i][ApplicationUtil.formTitle];
      _form.add(_dto);
    }
  }

  return _form;
}

Future<ResultDto> getMatch(int _match) async {
  ResultDao _dao = ResultDao();
  return await _dao.getResultById(_match);
}

List<RegistDto> getMatchParticipate(ResultDto _result) {
  final List<RegistDto> _participate = <RegistDto>[];
  var _quarter =
      _result.quarter == 5 ? _result.quarter - 2 : _result.quarter - 1;
  for (PlayerDto _player in _result.homeplayers) {
    if (_player.quarter[_quarter] == ApplicationUtil.play ||
        _player.quarter[_quarter] == ApplicationUtil.route ||
        _player.quarter[_quarter] == ApplicationUtil.reentry) {
      var _dto = RegistDto();
      _dto.team = _player.team;
      _dto.roster = _player.roster;
      _dto.member = _player.member;
      _dto.number = _player.number;
      _dto.role = _player.role;
      _dto.sort = _player.sort;
      _dto.ball = ApplicationUtil.stay;
      _dto.foul = ApplicationUtil.stay;
      _participate.add(_dto);
    }
  }
  for (PlayerDto _player in _result.awayplayers) {
    if (_player.quarter[_quarter] == ApplicationUtil.play ||
        _player.quarter[_quarter] == ApplicationUtil.route ||
        _player.quarter[_quarter] == ApplicationUtil.reentry) {
      var _dto = RegistDto();
      _dto.team = _player.team;
      _dto.roster = _player.roster;
      _dto.member = _player.member;
      _dto.number = _player.number;
      _dto.role = _player.role;
      _dto.sort = _player.sort;
      _dto.ball = ApplicationUtil.stay;
      _dto.foul = ApplicationUtil.stay;
      _participate.add(_dto);
    }
  }
  return _participate;
}

Future confirmMatchValue(List<FormDto> _form) async {
  MatchDao _dao = MatchDao();
  MatchDto _dto = MatchDto();

  _dto.name = _form[0].controller.text == '' ? null : _form[0].controller.text;
  _dto.date = _form[1].controller.text == '' ? null : _form[1].controller.text;
  _dto.place = _form[2].controller.text == '' ? '' : _form[2].controller.text;
  _dto.coat = _form[3].controller.text == '' ? '' : _form[3].controller.text;
  _dto.quarter = ApplicationUtil.prepare;
  _dto.status = ApplicationUtil.prepare;
  if (_form[4].controller.text == '') {
    _dto.hometeam = null;
  } else {
    _dto.hometeam = int.parse(_form[4].controller.text);
    _dto.homeware = _form[4].boolvalue == true
        ? ApplicationUtil.away
        : ApplicationUtil.home;
  }
  if (_form[6].controller.text == '') {
    _dto.awayteam = null;
  } else {
    _dto.awayteam = int.parse(_form[6].controller.text);
    _dto.awayware = ApplicationUtil.away;
  }
  if (_form[5].controller.text == '') {
    _dto.homeroster = null;
  } else {
    _dto.homeroster = int.parse(_form[5].controller.text);
  }
  if (_form[7].controller.text == '') {
    _dto.awayroster = null;
  } else {
    _dto.awayroster = int.parse(_form[7].controller.text);
  }

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  List<MatchDto> _match;
  int _count = await _dao.duplicateCount(_dto, [
    TableUtil.cName,
    TableUtil.cPlace,
    TableUtil.cCoat,
    TableUtil.cHometeam,
    TableUtil.cAwayteam,
    TableUtil.cHomeroster,
    TableUtil.cAwayroster
  ], [
    _dto.name,
    _dto.place,
    _dto.coat,
    _dto.hometeam,
    _dto.awayteam,
    _dto.homeroster,
    _dto.awayroster
  ]);
  if (_dto.id == null && _count > 0) {
    _match = await _dao.selectByNamePlaceTeamRoster(
        _dto.name,
        _dto.place,
        _dto.coat,
        _dto.hometeam,
        _dto.awayteam,
        _dto.homeroster,
        _dto.awayroster);
    if (_match[0].status == ApplicationUtil.definite) {
      // すでに確定した重複あり
      return -2;
    }
  }

  if (_dto.id == null && _match == null) {
    // 新規登録
    await _dao.insert(_dto);
    _match = await _dao.selectByNamePlaceTeamRoster(
        _dto.name,
        _dto.place,
        _dto.coat,
        _dto.hometeam,
        _dto.awayteam,
        _dto.homeroster,
        _dto.awayroster);

    RegistDao _registDao = RegistDao();
    RecordDao _recordDao = RecordDao();
    List<RegistDto> _homeRegists = await _registDao.selectByRosterId(
        int.parse(_form[5].controller.text),
        [TableUtil.cNumber, TableUtil.cRole],
        [TableUtil.asc, TableUtil.desc]);
    for (RegistDto _regist in _homeRegists) {
      RecordDto _record = RecordDto();
      _record.team = _dto.hometeam;
      _record.roster = _dto.homeroster;
      _record.match = _match[0].id;
      _record.member = _regist.member;
      await _recordDao.insert(_record);
    }
    List<RegistDto> _awayRegists = await _registDao.selectByRosterId(
        int.parse(_form[7].controller.text),
        [TableUtil.cNumber, TableUtil.cRole],
        [TableUtil.asc, TableUtil.desc]);
    for (RegistDto _regist in _awayRegists) {
      RecordDto _record = RecordDto();
      _record.team = _dto.awayteam;
      _record.roster = _dto.awayroster;
      _record.match = _match[0].id;
      _record.member = _regist.member;
      await _recordDao.insert(_record);
    }

    PeriodDao _periodDao = PeriodDao();
    PeriodDto _period = PeriodDto();
    for (int i = 0; i < 4; i++) {
      _period.match = _match[0].id;
      _period.team = _dto.hometeam;
      _period.period = i + 1;
      _period.score = 0;
      _period.timeout = null;
      _period.teamfoul = null;
      await _periodDao.insert(_period);
      _period.match = _match[0].id;
      _period.team = _dto.awayteam;
      _period.period = i + 1;
      _period.score = 0;
      _period.timeout = null;
      _period.teamfoul = null;
      await _periodDao.insert(_period);
    }
  }
  return _match[0].id;
}

Future deleteMatchValue(ApplicationBloc _bloc, ResultDto _result) async {
  PeriodDao _period = PeriodDao();
  await _period.deleteByMatch(_result.match.id);
  RecordDao _record = RecordDao();
  await _record.deleteByMatch(_result.match.id);
  MatchDao _match = MatchDao();
  await _match.deleteByMatch(_result.match.id);
}

Future<int> matchQuarterEdit(
    ResultDto _data, List<RegistDto> _select, int _index) async {
  var _checker = <int>[];
  int _roles = 0;
  for (int i = 0; i < ApplicationUtil.benchmember; i++) {
    if (_select[i].member == null) {
      return -1;
    }
    _checker.add(_select[i].member);
    _roles = _roles + _select[i].role;
  }
  if (_roles != ApplicationUtil.coach + ApplicationUtil.assistant) {
    return -2;
  }
  if (ApplicationUtil.benchmember != _checker.toSet().toList().length) {
    return 1;
  }
  _checker.clear();
  _roles = 0;
  for (int i = ApplicationUtil.benchmember;
      i < ApplicationUtil.benchmember + ApplicationUtil.benchmember;
      i++) {
    if (_select[i].member == null) {
      return -1;
    }
    _roles = _roles + _select[i].role;
    _checker.add(_select[i].member);
  }
  if (_roles != ApplicationUtil.coach + ApplicationUtil.assistant) {
    return -2;
  }
  if (ApplicationUtil.benchmember != _checker.toSet().toList().length) {
    return 1;
  }

  MatchDao _match = MatchDao();
  List<MatchDto> _dto = await _match.selectById(_data.match.id);
  if (_data.quarter - 1 == _index &&
      _dto[0].status == ApplicationUtil.progress) {
    _dto[0].status = ApplicationUtil.prepare;
    _data.status = ApplicationUtil.prepare;
    await _match.update(_dto[0]);
    _data.match = _dto[0];
    PeriodDao _periodDao = PeriodDao();
    List<PeriodDto> _periods = await _periodDao.selectByMatchTeam(
        _data.match.id, _data.match.hometeam);
    _periods[_index].status = ApplicationUtil.definite;
    await _periodDao.update(_periods[_index]);
    _periods = await _periodDao.selectByMatchTeam(
        _data.match.id, _data.match.awayteam);
    _periods[_index].status = ApplicationUtil.definite;
    await _periodDao.update(_periods[_index]);
    return 0;
  } else if (_data.quarter == _index &&
      _dto[0].status == ApplicationUtil.prepare) {
    _dto[0].quarter = _data.quarter + 1;
    _dto[0].status = ApplicationUtil.progress;
    await _match.update(_dto[0]);
    _data.quarter++;
    _data.match = _dto[0];
    if (_index == 4) {
      _dto[0].status = ApplicationUtil.progress;
      _data.status = ApplicationUtil.progress;
      PeriodDao _periodDao = PeriodDao();
      PeriodDto _period = PeriodDto();
      _period.match = _data.match.id;
      _period.team = _data.match.hometeam;
      _period.period = 5;
      _period.score = 0;
      _period.timeout = null;
      _period.teamfoul = null;
      await _periodDao.insert(_period);
      _data.homeperiod.add(_period);
      _period.match = _data.match.id;
      _period.team = _data.match.awayteam;
      _period.period = 5;
      _period.score = 0;
      _period.timeout = null;
      _period.teamfoul = null;
      await _periodDao.insert(_period);
      _data.awayperiod.add(_period);
    }
    _data.match = _dto[0];

    RecordDao _record = RecordDao();
    for (RegistDto _regist in _select) {
      List<RecordDto> _records = await _record.selectByMatchTeamRosterMember(
          _data.match.id, _regist.team, _regist.roster, _regist.member);
      switch (_index) {
        case 0:
          _records[0].quarter1 = ApplicationUtil.play;
          break;
        case 1:
          _records[0].quarter2 = ApplicationUtil.play;
          break;
        case 2:
          _records[0].quarter3 = ApplicationUtil.play;
          break;
        case 3:
          _records[0].quarter4 = ApplicationUtil.play;
          break;
        case 4:
          _records[0].quarter4 = ApplicationUtil.play;
          break;
      }
      await _record.update(_records[0]);
    }
    return 0;
  } else {
    if (_index + 1 <= _data.quarter) {
      return 4;
    }
    if (_data.match.status == ApplicationUtil.prepare) {
      return 3;
    } else {
      return 2;
    }
  }
}

Future<RegistDto> matchMemberEntry(ResultDto _data, int _side) async {
  TeamDto _team = getHomeAway(_data, _side, ApplicationUtil.teamdata);

  String _result = await showSelectDialog(
    context: _data.context,
    title: _team.name,
    value: _team.id,
  );

  int _roster;
  if (_side == ApplicationUtil.home) {
    _roster = _data.match.homeroster;
  } else {
    _roster = _data.match.awayroster;
  }
  List<RegistDto> _record;
  if (_result != null && _result.isNotEmpty) {
    RegistDao _rDao = RegistDao();
    _record = await _rDao.selectByRosterMember(_roster, int.parse(_result));
  }

  return _record[0];
}

Future<bool> incrementTimeOut(ResultDto _data, int _side) async {
  TeamDto _team = getHomeAway(_data, _side, ApplicationUtil.teamdata);

  PeriodDao _period = PeriodDao();
  List<PeriodDto> _periods =
      await _period.selectByMatchTeam(_data.match.id, _team.id);

  if (_periods[_data.quarter - 1].timeout == ApplicationUtil.use) {
    return false;
  }
  _periods[_data.quarter - 1].timeout = ApplicationUtil.use;
  await _period.update(_periods[_data.quarter - 1]);
  _side == ApplicationUtil.home
      ? _data.homeperiod = _periods
      : _data.awayperiod = _periods;

  return true;
}

Future<List<RegistDto>> matchMemberAction(ResultDto _data,
    List<RegistDto> _select, int _selectid, int _side, int _function) async {
  TeamDto _team = getHomeAway(_data, _side, ApplicationUtil.teamdata);

  switch (_function) {
    case ApplicationUtil.typeFieldgoal:
    case ApplicationUtil.typeFreethrow:
      _pointAction(_data, _select, _selectid, _side, _function);
      break;
    case ApplicationUtil.typeOwngoal:
      _pointAction(_data, _select, _selectid, _side, _function);
      break;
    case ApplicationUtil.typeTechnical:
    case ApplicationUtil.typeUnsportsman:
    case ApplicationUtil.typeDisqualifying:
    case ApplicationUtil.typeMantoman:
    case ApplicationUtil.typeNotgain:
    case ApplicationUtil.typeGain:
    case ApplicationUtil.typeCoach:
    case ApplicationUtil.typeBench:
      _foulAction(_data, _team, _select, _selectid, _side, _function);
      break;
    default:
  }
  _select[_selectid].ball = ApplicationUtil.stay;
  _select[_selectid].foul = ApplicationUtil.stay;

  return _select;
}

void _pointAction(ResultDto _data, List<RegistDto> _select, int _selectid,
    int _side, int _function) async {
  TeamDto _team;
  if (_function == ApplicationUtil.typeOwngoal) {
    _team = _side == ApplicationUtil.home
        ? getHomeAway(_data, ApplicationUtil.away, ApplicationUtil.teamdata)
        : getHomeAway(_data, ApplicationUtil.home, ApplicationUtil.teamdata);
  } else {
    _team = getHomeAway(_data, _side, ApplicationUtil.teamdata);
  }

  int _point = _function == ApplicationUtil.typeFreethrow
      ? ApplicationUtil.freethrow
      : ApplicationUtil.fieldgoal;

  PeriodDao _period = PeriodDao();
  List<PeriodDto> _periods =
      await _period.selectByMatchTeam(_data.match.id, _team.id);

  _periods[_data.quarter - 1].score =
      _periods[_data.quarter - 1].score + _point;
  await _period.update(_periods[_data.quarter - 1]);

  ScoreDao _sdao = ScoreDao();
  ScoreDto _sdto = ScoreDto();

  _sdto.match = _data.match.id;
  _sdto.team = _team.id;
  _sdto.period = _data.quarter;
  _sdto.point = _point;
  if (_function == ApplicationUtil.typeOwngoal) {
    _sdto.member = 0;
    _sdto.score =
        _side == ApplicationUtil.home ? _data.awaytotal : _data.hometotal;
  } else {
    _sdto.member = _select[_selectid].member;
    _sdto.score =
        _side == ApplicationUtil.home ? _data.hometotal : _data.awaytotal;
  }
  await _sdao.insert(_sdto);
}

void _foulAction(ResultDto _data, TeamDto _team, List<RegistDto> _select,
    int _selectid, int _side, int _function) async {
  String _foul;
  switch (_select[_selectid].foul) {
    case ApplicationUtil.typePersonal:
      String _ft = _function == ApplicationUtil.typeNotgain ? '' : "'";
      _foul = 'P' + _ft + _data.quarter.toString();
      break;
    case ApplicationUtil.typeTechnical:
      if (_select[_selectid].role == ApplicationUtil.player) {
        _foul = 'T' + _data.quarter.toString();
      } else if (_function == ApplicationUtil.typeCoach) {
        _foul = 'C' + _data.quarter.toString();
      } else if (_function == ApplicationUtil.typeBench) {
        _foul = 'B' + _data.quarter.toString();
      }
      break;
    case ApplicationUtil.typeUnsportsman:
      _foul = 'U' + _data.quarter.toString();
      break;
    case ApplicationUtil.typeDisqualifying:
      _foul = 'D' + _data.quarter.toString();
      break;
    case ApplicationUtil.typeMantoman:
      _foul = 'M' + _data.quarter.toString();
  }

  if (_select[_selectid].foul != ApplicationUtil.typePersonal ||
      _select[_selectid].foul != ApplicationUtil.typeTechnical ||
      _select[_selectid].foul != ApplicationUtil.typeUnsportsman) {
    PeriodDao _period = PeriodDao();
    List<PeriodDto> _periods =
        await _period.selectByMatchTeam(_data.match.id, _team.id);

    _periods[_data.quarter - 1].teamfoul =
        _periods[_data.quarter - 1].teamfoul == null
            ? 1
            : _periods[_data.quarter - 1].teamfoul + 1;
    await _period.update(_periods[_data.quarter - 1]);
  }

  RecordDao _record = RecordDao();
  List<RecordDto> _records = await _record.selectByMatchTeamRosterMember(
      _data.match.id,
      _team.id,
      _select[_selectid].roster,
      _select[_selectid].member);

  int _count = _getFoulCount(_records[0]);
  switch (_count) {
    case 1:
      _records[0].foul1 = _foul;
      break;
    case 2:
      _records[0].foul2 = _foul;
      break;
    case 3:
      _records[0].foul3 = _foul;
      break;
    case 4:
      _records[0].foul4 = _foul;
      break;
    case 5:
      _records[0].foul5 = _foul;
      break;
  }
  await _record.update(_records[0]);

  // 失格退場
}

int _getFoulCount(RecordDto _record) {
  if (_record.foul1 == null || _record.foul1 == '') {
    return 1;
  } else if (_record.foul2 == null || _record.foul2 == '') {
    return 2;
  } else if (_record.foul3 == null || _record.foul3 == '') {
    return 3;
  } else if (_record.foul4 == null || _record.foul4 == '') {
    return 4;
  } else if (_record.foul5 == null || _record.foul5 == '') {
    return 5;
  } else {
    return 0;
  }
}

Future<List<RegistDto>> matchMemberChange(ResultDto _data,
    List<RegistDto> _select, int _out, int _in, int _side) async {
  List<PlayerDto> _players =
      getHomeAway(_data, _side, ApplicationUtil.playerdata);

  RecordDao _record = RecordDao();
  List<RecordDto> _inrec;
  List<RecordDto> _outrec;
  PlayerDto _in_player;
  for (PlayerDto _player in _players) {
    if (_player.member == _in) {
      _inrec = await _record.selectByMatchTeamRosterMember(
          _data.match.id, _player.team, _player.roster, _player.member);
      _inclementQuarter(_data, _inrec);
      _in_player = _player;
    }
  }
  for (PlayerDto _player in _players) {
    if (_player.member == _out) {
      _outrec = await _record.selectByMatchTeamRosterMember(
          _data.match.id, _player.team, _player.roster, _player.member);
      _inclementQuarter(_data, _outrec);
    }
  }
  await _record.update(_inrec[0]);
  await _record.update(_outrec[0]);
  for (int i = 0; i < _select.length; i++) {
    if (_select[i].ball == ApplicationUtil.play) {
      _select[i].id = _inrec[0].id;
      _select[i].team = _inrec[0].team;
      _select[i].roster = _inrec[0].roster;
      _select[i].member = _inrec[0].member;
      _select[i].number = _in_player.number;
      _select[i].role = _in_player.role;
      _select[i].sort = _in_player.sort;
      _select[i].ball = ApplicationUtil.stay;
      _select[i].foul = ApplicationUtil.stay;
    }
  }

  return _select;
}

void _inclementQuarter(ResultDto _data, List<RecordDto> _player) {
  switch (_data.quarter) {
    case 1:
      _player[0].quarter1 = _player[0].quarter1 == null
          ? ApplicationUtil.route
          : _player[0].quarter1 + 1;
      break;
    case 2:
      _player[0].quarter2 = _player[0].quarter2 == null
          ? ApplicationUtil.route
          : _player[0].quarter2 + 1;
      break;
    case 3:
      _player[0].quarter3 = _player[0].quarter3 == null
          ? ApplicationUtil.route
          : _player[0].quarter3 + 1;
      break;
    case 4:
      _player[0].quarter4 = _player[0].quarter4 == null
          ? ApplicationUtil.route
          : _player[0].quarter4 + 1;
      break;
    case 5:
      _player[0].quarter4 = _player[0].quarter4 == null
          ? ApplicationUtil.route
          : _player[0].quarter4 + 1;
      break;
    default:
  }
}

void matchGameAction(ResultDto _data) async {
  MatchDao _match = MatchDao();
  _data.match.status = ApplicationUtil.definite;
  await _match.update(_data.match);
}
