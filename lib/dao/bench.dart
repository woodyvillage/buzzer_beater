import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/bench.dart';
import 'package:buzzer_beater/dto/team.dart';

class BenchDao {
  Future<List<BenchDto>> getAllBench(MatchDto _match, TeamDto _team) async {
    List<BenchDto> bench = <BenchDto>[];

    RosterDao _rdao = RosterDao();
    List<RosterDto> _roster = await _rdao.selectMatchByTeamId(_match.id, _team);
    for (RosterDto _person in _roster) {
      MemberDao _mdao = MemberDao();
      List<MemberDto> _member = await _mdao.selectById(_person.member);

      var _bench = BenchDto()
        ..match = _match.id
        ..team = _team.id
        ..number = _person.number
        ..role = _person.role
        ..name = _member[0].name
        ..age = _member[0].age
        ..regist = _member[0].regist
        ..image = _member[0].image == null ? 'null' : _member[0].image
        ..quota = [_person.q1, _person.q2, _person.q3, _person.q4]
        ..foul = [_person.f1, _person.f2, _person.f3, _person.f4, _person.f5];
      bench.add(_bench);
    }

    return bench;
  }
}
