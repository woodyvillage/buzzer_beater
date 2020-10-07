import 'package:buzzer_beater/dao/bench.dart';
import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/scoreprogress.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/bench.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class ResultDao {
  Future<List<ResultDto>> getAllResult() async {
    var result = <ResultDto>[];

    MatchDao _mdao = MatchDao();
    List<MatchDto> _mdto = await _mdao.select(TableUtil.cDate);

    for (MatchDto _match in _mdto) {
      TeamDao _tdao = TeamDao();
      List<TeamDto> _home = await _tdao.selectById(_match.hometeam);
      List<TeamDto> _away = await _tdao.selectById(_match.awayteam);

      PeriodDao _pdao = PeriodDao();
      int _hometotal = await _pdao.sumMatchByTeamId(_match.id, _home[0]);
      int _awaytotal = await _pdao.sumMatchByTeamId(_match.id, _away[0]);
      List<PeriodDto> _homeperiod =
          await _pdao.selectMatchByTeamId(_match.id, _home[0]);
      List<PeriodDto> _awayperiod =
          await _pdao.selectMatchByTeamId(_match.id, _away[0]);

      BenchDao _bdao = BenchDao();
      List<BenchDto> _homebench = await _bdao.getAllBench(_match, _home[0]);
      List<BenchDto> _awaybench = await _bdao.getAllBench(_match, _away[0]);

      var _max = _hometotal > _awaytotal ? _hometotal : _awaytotal;
      ScoreProgressDao _sdao = ScoreProgressDao();
      List<ScoreProgressDto> _homeprogress =
          await _sdao.getAllScoreProgress(_match, _home[0], _max);
      List<ScoreProgressDto> _awayprogress =
          await _sdao.getAllScoreProgress(_match, _away[0], _max);

      var _result = ResultDto()
        ..match = _match
        ..home = _home[0]
        ..away = _away[0]
        ..hometotal = _hometotal
        ..awaytotal = _awaytotal
        ..homeperiod = _homeperiod
        ..awayperiod = _awayperiod
        ..homebench = _homebench
        ..awaybench = _awaybench
        ..homeprogress = _homeprogress
        ..awayprogress = _awayprogress;
      result.add(_result);
    }

    return result;
  }
}
