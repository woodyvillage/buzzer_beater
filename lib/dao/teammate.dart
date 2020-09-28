import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/dto/teammate.dart';
import 'package:buzzer_beater/util/table.dart';

class TeamMateDao {
  Future<List<TeamMateDto>> getAllMember() async {
    var teammate = List<TeamMateDto>();

    TeamDao _tdao = TeamDao();
    List<TeamDto> _tdto = await _tdao.select(TableUtil.cName);

    MemberDao _mdao = MemberDao();
    for (int i = 0; i < _tdto.length; i++) {
      List<MemberDto> _mdto = await _mdao.selectByTeamId(_tdto[i], TableUtil.cAge);
      var _teammate = TeamMateDto()
        ..team = _tdto[i]
        ..members = _mdto
        ..expanded = true;
      teammate.add(_teammate);
    }

    return teammate;
  }
}