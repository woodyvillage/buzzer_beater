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
    List<TeamDto> _tdto = await _tdao.select(TableUtil.cId);

    MemberDao _mdao = MemberDao();
    for (int i = 0; i < _tdto.length; i++) {
      List<MemberDto> _mdto = await _mdao.selectByTeamId(
          _tdto[i].id, TableUtil.cAge, TableUtil.desc);
      var _enroll = EnrollDto()
        ..expanded = false
        ..team = _tdto[i]
        ..members = _mdto;
      enroll.add(_enroll);
    }

    return enroll;
  }
}
