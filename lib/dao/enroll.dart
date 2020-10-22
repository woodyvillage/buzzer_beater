import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/dto/enroll.dart';
import 'package:buzzer_beater/util/table.dart';

class EnrollDao {
  Future<List<EnrollDto>> getEnroll() async {
    var enroll = <EnrollDto>[];
    TeamDao _tdao = TeamDao();
    MemberDao _mdao = MemberDao();

    List<TeamDto> _tdto = await _tdao.select(TableUtil.cId);

    for (TeamDto _team in _tdto) {
      List<MemberDto> _mdto =
          await _mdao.selectByTeamId(_team.id, TableUtil.cAge, TableUtil.desc);
      var _enroll = EnrollDto()
        ..expanded = false
        ..team = _team
        ..members = _mdto;
      enroll.add(_enroll);
    }

    return enroll;
  }
}
