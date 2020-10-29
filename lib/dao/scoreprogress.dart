import 'package:buzzer_beater/dao/player.dart';
import 'package:buzzer_beater/dao/score.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';

class ScoreProgressDao {
  Future<List<ScoreProgressDto>> getAllScoreProgress(
      MatchDto _match, int _roster, TeamDto _team, int _max) async {
    List<ScoreProgressDto> scoreprogress = <ScoreProgressDto>[];

    for (int i = 1; i <= _max; i++) {
      ScoreDao _sdao = ScoreDao();
      List<ScoreDto> _score =
          await _sdao.selectByMatchTeamScore(_match.id, _team.id, i);
      if (_score.isNotEmpty) {
        if (_score[0].member == 0) {
          var _scoreprogress = ScoreProgressDto()
            ..score = i
            ..point = _score[0].point
            ..number = -1
            ..name = null
            ..image = null;
          scoreprogress.add(_scoreprogress);
        } else {
          PlayerDao _pdao = PlayerDao();
          List<PlayerDto> _pdto =
              await _pdao.getByMemberId(_roster, _score[0].member);
          var _image = _pdto[0].image == null ? 'null' : _pdto[0].image;
          var _scoreprogress = ScoreProgressDto()
            ..score = i
            ..point = _score[0].point
            ..number = _pdto[0].number
            ..name = _pdto[0].name
            ..image = _image;
          scoreprogress.add(_scoreprogress);
        }
      } else {
        var _scoreprogress = ScoreProgressDto()
          ..score = i
          ..point = null
          ..number = null
          ..name = null
          ..image = null;
        scoreprogress.add(_scoreprogress);
      }
    }

    return scoreprogress;
  }
}
