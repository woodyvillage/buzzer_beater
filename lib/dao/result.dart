import 'package:buzzer_beater/dao/match.dart';
import 'package:buzzer_beater/dao/period.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/util/table.dart';

class ResultDao {
  Future<List<ResultDto>> getAllResult() async {
    var result = List<ResultDto>();

    MatchDao _mdao = MatchDao();
    List<MatchDto> _mdto = await _mdao.select(TableUtil.cDate);

    for (int i = 0; i < _mdto.length; i++) {
      TeamDao _tdao = TeamDao();
      List<TeamDto> _home = await _tdao.selectById(_mdto[i].hometeam);
      List<TeamDto> _away = await _tdao.selectById(_mdto[i].awayteam);

      PeriodDao _pdao = PeriodDao();
      int _homescore = await _pdao.sumByMatchId(_mdto[i].id, _home[0]);
      int _awayscore = await _pdao.sumByMatchId(_mdto[i].id, _away[0]);
      List<PeriodDto> _homeperiod = await _pdao.selectByTeamId(_mdto[i].id, _home[0]);
      List<PeriodDto> _awayperiod = await _pdao.selectByTeamId(_mdto[i].id, _away[0]);

      var _result = ResultDto()
        ..match = _mdto[i]
        ..home = _home[0]
        ..away = _away[0]
        ..homescore = _homescore
        ..awayscore = _awayscore
        ..homeperiod = _homeperiod
        ..awayperiod = _awayperiod;
      result.add(_result);
    }

    return result;
  }
}