import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/player.dart';
import 'package:buzzer_beater/dao/scoreprogress.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/table.dart';

class ResultDao {
  Future<List<ResultDto>> getResult() async {
    MatchDao _mdao = MatchDao();
    List<MatchDto> _mdto =
        await _mdao.selectByStatus(TableUtil.cDate, ApplicationUtil.definite);
    return _getResult(_mdto, false);
  }

  Future<List<ResultDto>> getProgressResult() async {
    MatchDao _mdao = MatchDao();
    List<MatchDto> _mdto = await _mdao.selectByNotStatus(
        TableUtil.cDate, ApplicationUtil.definite);
    return _mdto == null ? null : _getResult(_mdto, false);
  }

  Future<ResultDto> getResultById(int _value) async {
    MatchDao _mdao = MatchDao();
    List<MatchDto> _mdto = await _mdao.selectById(_value);
    var _result = await _getResult(_mdto, true);
    return _result[0];
  }

  Future<List<ResultDto>> _getResult(
      List<MatchDto> _matches, bool isQuarter) async {
    var result = <ResultDto>[];
    for (MatchDto _match in _matches) {
      TeamDao _tdao = TeamDao();
      List<TeamDto> _home = await _tdao.selectById(_match.hometeam);
      List<TeamDto> _away = await _tdao.selectById(_match.awayteam);

      PeriodDao _pdao = PeriodDao();
      int _hometotal = await _pdao.sumByMatchTeam(_match.id, _home[0].id);
      _hometotal ??= 0;
      int _awaytotal = await _pdao.sumByMatchTeam(_match.id, _away[0].id);
      _awaytotal ??= 0;

      List<PeriodDto> _homeperiod =
          await _pdao.selectByMatchTeam(_match.id, _home[0].id);
      List<PeriodDto> _awayperiod =
          await _pdao.selectByMatchTeam(_match.id, _away[0].id);

      PlayerDao _dao = PlayerDao();
      List<PlayerDto> _homeplayer =
          await _dao.getMatchByRosterId(_match.homeroster, _match.id);
      List<PlayerDto> _awayplayer =
          await _dao.getMatchByRosterId(_match.awayroster, _match.id);

      var _max = _hometotal > _awaytotal ? _hometotal : _awaytotal;
      ScoreProgressDao _sdao = ScoreProgressDao();
      List<ScoreProgressDto> _homeprogress = await _sdao.getAllScoreProgress(
          _match, _match.homeroster, _home[0], _max);
      List<ScoreProgressDto> _awayprogress = await _sdao.getAllScoreProgress(
          _match, _match.awayroster, _away[0], _max);

      var _result = ResultDto()
        ..match = _match
        ..home = _home[0]
        ..away = _away[0]
        ..hometotal = _hometotal
        ..awaytotal = _awaytotal
        ..homeperiod = _homeperiod
        ..awayperiod = _awayperiod
        ..homeplayers = _homeplayer
        ..awayplayers = _awayplayer
        ..homeprogress = _homeprogress
        ..awayprogress = _awayprogress
        ..quarter = _match.quarter
        ..status = _match.status;
      result.add(_result);
    }

    return result;
  }
}
