import 'package:intl/intl.dart';

import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dao/score.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/result.dart';

final ApplicationPreference _pref = ApplicationPreference();

Future getSetting(List<Object> _settings) async {
  Future<dynamic> _result = await _pref.getValue(_settings[3], _settings[4]);
  _result ??= _settings[4];
  return _result;
}

dynamic getHomeAway(ResultDto _data, int _side, int _type) {
  dynamic _result;
  switch (_type) {
    case ResultUtil.team:
      _side == ResultUtil.home ? _result = _data.home : _result = _data.away;
      break;
    case ResultUtil.total:
      _side == ResultUtil.home
          ? _result = _data.hometotal
          : _result = _data.awaytotal;
      break;
    case ResultUtil.period:
      _side == ResultUtil.home
          ? _result = _data.homeperiod
          : _result = _data.awayperiod;
      break;
    case ResultUtil.bench:
      _side == ResultUtil.home
          ? _result = _data.homebench
          : _result = _data.awaybench;
      break;
    case ResultUtil.progress:
      _side == ResultUtil.home
          ? _result = _data.homeprogress
          : _result = _data.awayprogress;
      break;
  }
  return _result;
}

bool isPeriod(List<PeriodDto> _data, int _index) {
  int _sum = 0;
  for (int i = 0; i < _data.length; i++) {
    _sum += _data[i].score;
    if (_sum == _index + 1) {
      return true;
    } else if (_sum > _index) {
      break;
    }
  }
  return false;
}

void test() async {
  MemberDao _dao = MemberDao();
  MemberDto _dto = MemberDto();

  _dto.team = 1;

  _dto.name = 'たろう';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 4;
  await _dao.insert(_dto);

  _dto.name = 'ひとし';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 5;
  await _dao.insert(_dto);

  _dto.name = 'たつや';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 6;
  await _dao.insert(_dto);

  _dto.name = 'こうじ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 7;
  await _dao.insert(_dto);

  _dto.name = 'ともひろ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 8;
  await _dao.insert(_dto);

  _dto.name = 'まさる';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 9;
  await _dao.insert(_dto);

  _dto.name = 'けんた';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 10;
  await _dao.insert(_dto);

  _dto.name = 'だいすけ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 11;
  await _dao.insert(_dto);

  _dto.name = 'つよし';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 12;
  await _dao.insert(_dto);

  _dto.name = 'すすむ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = null;
  await _dao.insert(_dto);

  _dto.name = 'かんとく';
  _dto.age = 55;
  _dto.regist = 1234567;
  _dto.number = null;
  await _dao.insert(_dto);

  _dto.name = 'コーチ';
  _dto.age = 41;
  _dto.regist = 1234567;
  _dto.number = null;
  await _dao.insert(_dto);

  _dto.team = 2;

  _dto.name = 'ひでお';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 14;
  await _dao.insert(_dto);

  _dto.name = 'さとし';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 15;
  await _dao.insert(_dto);

  _dto.name = 'ゆうじ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 16;
  await _dao.insert(_dto);

  _dto.name = 'とおる';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 17;
  await _dao.insert(_dto);

  _dto.name = 'きょうすけ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 18;
  await _dao.insert(_dto);

  _dto.name = 'しんいち';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 19;
  await _dao.insert(_dto);

  _dto.name = 'みつる';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 20;
  await _dao.insert(_dto);

  _dto.name = 'てつお';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 21;
  await _dao.insert(_dto);

  _dto.name = 'はやと';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 22;
  await _dao.insert(_dto);

  _dto.name = 'しゅうじ';
  _dto.age = 12;
  _dto.regist = 1234567;
  _dto.number = 23;
  await _dao.insert(_dto);

  _dto.name = 'ヘッドコーチ';
  _dto.age = 55;
  _dto.regist = 1234567;
  _dto.number = null;
  await _dao.insert(_dto);

  _dto.name = 'シニアコーチ';
  _dto.age = 41;
  _dto.regist = 1234567;
  _dto.number = null;
  await _dao.insert(_dto);

  TeamDao _tdao = TeamDao();

  List<TeamDto> _home = await _tdao.selectById(1);
  for (int i = 0; i < _home.length; i++) {
    _home[i].name = 'ダブルドリブル';
    await _tdao.update(_home[i]);
  }

  List<TeamDto> _away = await _tdao.selectById(2);
  for (int i = 0; i < _away.length; i++) {
    _away[i].name = 'アンクルブレイク';
    await _tdao.update(_away[i]);
  }

  MatchDao _mdao = MatchDao();
  MatchDto _mdto = MatchDto();

  var _dateFormat = DateFormat('yyyy年MM月dd日(E) HH:mm', 'ja_JP');
  var _date = _dateFormat.format(DateTime.now());
  _mdto.name = '県大会予選';
  _mdto.date = _date;
  _mdto.hometeam = 1;
  _mdto.awayteam = 2;
  _mdto.homemain = _home[0].majormain;
  _mdto.homeshade = _home[0].majorshade;
  _mdto.awaymain = _away[0].majormain;
  _mdto.awayshade = _away[0].majorshade;
  await _mdao.insert(_mdto);

  PeriodDao _pdao = PeriodDao();
  PeriodDto _pdto = PeriodDto();

  _pdto.match = 1;
  _pdto.team = 1;
  _pdto.period = 1;
  _pdto.score = 8;
  _pdto.timeout = 1;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);
  _pdto.period = 2;
  _pdto.score = 6;
  _pdto.timeout = 0;
  _pdto.teamfoul = 2;
  await _pdao.insert(_pdto);
  _pdto.period = 3;
  _pdto.score = 12;
  _pdto.timeout = 1;
  _pdto.teamfoul = 4;
  await _pdao.insert(_pdto);
  _pdto.period = 4;
  _pdto.score = 9;
  _pdto.timeout = 0;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);

  _pdto.match = 1;
  _pdto.team = 2;
  _pdto.period = 1;
  _pdto.score = 12;
  _pdto.timeout = 0;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);
  _pdto.period = 2;
  _pdto.score = 12;
  _pdto.timeout = 0;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);
  _pdto.period = 3;
  _pdto.score = 8;
  _pdto.timeout = 0;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);
  _pdto.period = 4;
  _pdto.score = 7;
  _pdto.timeout = 0;
  _pdto.teamfoul = 0;
  await _pdao.insert(_pdto);

  ScoreDao _sdao = ScoreDao();
  ScoreDto _sdto = ScoreDto();

  _sdto.match = 1;
  _sdto.team = 1;

  _sdto.member = 1;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 2;
  await _sdao.insert(_sdto);
  _sdto.member = 2;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 4;
  await _sdao.insert(_sdto);
  _sdto.member = 0;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 6;
  await _sdao.insert(_sdto);
  _sdto.member = 2;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 8;
  await _sdao.insert(_sdto);

  _sdto.member = 2;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 10;
  await _sdao.insert(_sdto);
  _sdto.member = 2;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 12;
  await _sdao.insert(_sdto);
  _sdto.member = 3;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 14;
  await _sdao.insert(_sdto);

  _sdto.member = 3;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 16;
  await _sdao.insert(_sdto);
  _sdto.member = 1;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 18;
  await _sdao.insert(_sdto);
  _sdto.member = 3;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 20;
  await _sdao.insert(_sdto);
  _sdto.member = 3;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 22;
  await _sdao.insert(_sdto);
  _sdto.member = 1;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 24;
  await _sdao.insert(_sdto);
  _sdto.member = 1;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 26;
  await _sdao.insert(_sdto);

  _sdto.member = 1;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 28;
  await _sdao.insert(_sdto);
  _sdto.member = 2;
  _sdto.period = 4;
  _sdto.point = 1;
  _sdto.score = 29;
  await _sdao.insert(_sdto);
  _sdto.member = 2;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 31;
  await _sdao.insert(_sdto);
  _sdto.member = 3;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 33;
  await _sdao.insert(_sdto);
  _sdto.member = 1;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 35;
  await _sdao.insert(_sdto);

  _sdto.match = 1;
  _sdto.team = 2;

  _sdto.member = 14;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 2;
  await _sdao.insert(_sdto);
  _sdto.member = 14;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 4;
  await _sdao.insert(_sdto);
  _sdto.member = 14;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 6;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 8;
  await _sdao.insert(_sdto);
  _sdto.member = 14;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 10;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 1;
  _sdto.point = 2;
  _sdto.score = 12;
  await _sdao.insert(_sdto);

  _sdto.member = 15;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 14;
  await _sdao.insert(_sdto);
  _sdto.member = 14;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 16;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 18;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 20;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 22;
  await _sdao.insert(_sdto);
  _sdto.member = 14;
  _sdto.period = 2;
  _sdto.point = 2;
  _sdto.score = 24;
  await _sdao.insert(_sdto);

  _sdto.member = 14;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 26;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 28;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 3;
  _sdto.point = 1;
  _sdto.score = 29;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 3;
  _sdto.point = 2;
  _sdto.score = 31;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 3;
  _sdto.point = 1;
  _sdto.score = 32;
  await _sdao.insert(_sdto);

  _sdto.member = 14;
  _sdto.period = 4;
  _sdto.point = 1;
  _sdto.score = 33;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 35;
  await _sdao.insert(_sdto);
  _sdto.member = 15;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 37;
  await _sdao.insert(_sdto);
  _sdto.member = 16;
  _sdto.period = 4;
  _sdto.point = 2;
  _sdto.score = 39;
  await _sdao.insert(_sdto);

  RosterDao _rdao = RosterDao();
  RosterDto _rdto = RosterDto();

  _rdto.match = 1;
  _rdto.team = 1;

  _rdto.member = 1;
  _rdto.number = 4;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 2;
  _rdto.number = 5;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = "p1'";
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 3;
  _rdto.number = 6;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = "p1'";
  _rdto.f2 = "p1'";
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 4;
  _rdto.number = 7;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = "p1'";
  _rdto.f2 = "p1'";
  _rdto.f3 = "p2";
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 5;
  _rdto.number = 8;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 1;
  _rdto.f1 = "p1'";
  _rdto.f2 = "p1'";
  _rdto.f3 = "p2";
  _rdto.f4 = "p3";
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 6;
  _rdto.number = 9;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 2;
  _rdto.f1 = "p1'";
  _rdto.f2 = "p1'";
  _rdto.f3 = "p2";
  _rdto.f4 = "p3";
  _rdto.f5 = "p4'";
  await _rdao.insert(_rdto);
  _rdto.member = 7;
  _rdto.number = 10;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 8;
  _rdto.number = 11;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 9;
  _rdto.number = 12;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 10;
  _rdto.number = 13;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 11;
  _rdto.number = -1;
  _rdto.role = 2;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 12;
  _rdto.number = -1;
  _rdto.role = 1;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);

  _rdto.team = 2;

  _rdto.member = 13;
  _rdto.number = 7;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 14;
  _rdto.number = 8;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 15;
  _rdto.number = 9;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 16;
  _rdto.number = 10;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 17;
  _rdto.number = 11;
  _rdto.role = 0;
  _rdto.q1 = 0;
  _rdto.q2 = 1;
  _rdto.q3 = 0;
  _rdto.q4 = 1;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 18;
  _rdto.number = 12;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 19;
  _rdto.number = 13;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 20;
  _rdto.number = 14;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 21;
  _rdto.number = 15;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 22;
  _rdto.number = 16;
  _rdto.role = 0;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 23;
  _rdto.number = -1;
  _rdto.role = 2;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
  _rdto.member = 24;
  _rdto.number = -1;
  _rdto.role = 1;
  _rdto.q1 = 1;
  _rdto.q2 = 0;
  _rdto.q3 = 1;
  _rdto.q4 = 0;
  _rdto.f1 = '';
  _rdto.f2 = '';
  _rdto.f3 = '';
  _rdto.f4 = '';
  _rdto.f5 = '';
  await _rdao.insert(_rdto);
}
