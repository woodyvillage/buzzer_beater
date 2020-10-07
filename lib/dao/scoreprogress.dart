import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dao/score.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';

class ScoreProgressDao {
  Future<List<ScoreProgressDto>> getAllScoreProgress(
      MatchDto _match, TeamDto _team, int _max) async {
    List<ScoreProgressDto> scoreprogress = <ScoreProgressDto>[];

    for (int i = 1; i <= _max; i++) {
      ScoreDao _sdao = ScoreDao();
      List<ScoreDto> _score = await _sdao.selectByScoreId(i, _match, _team);
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
          RosterDao _rdao = RosterDao();
          List<RosterDto> _regular = await _rdao.selectById(_score[0].member);
          MemberDao _mdao = MemberDao();
          List<MemberDto> _member = await _mdao.selectById(_score[0].member);
          _member[0].image ??= 'null';
          var _scoreprogress = ScoreProgressDto()
            ..score = i
            ..point = _score[0].point
            ..number = _regular[0].number
            ..name = _member[0].name
            ..image = _member[0].image;
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
