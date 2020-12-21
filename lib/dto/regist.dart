import 'package:buzzer_beater/util/table.dart';

class RegistDto {
  int id;
  int team;
  int roster;
  int member;
  int number;
  int role;
  int captain;
  int sort;
  int ball;
  int foul;
  int delflg;

  RegistDto({
    this.id,
    this.team,
    this.roster,
    this.member,
    this.number,
    this.role,
    this.captain,
    this.sort,
    this.ball,
    this.foul,
    this.delflg,
  });

  factory RegistDto.parse(Map<String, dynamic> _record) => RegistDto(
        id: _record[TableUtil.cId],
        team: _record[TableUtil.cTeam],
        roster: _record[TableUtil.cRoster],
        member: _record[TableUtil.cMember],
        number: _record[TableUtil.cNumber],
        role: _record[TableUtil.cRole],
        captain: _record[TableUtil.cCaptain],
        sort: _record[TableUtil.cSort],
        ball: _record[TableUtil.cBall],
        foul: _record[TableUtil.cFoul],
        delflg: _record[TableUtil.cDelFlg],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cTeam: team,
        TableUtil.cRoster: roster,
        TableUtil.cMember: member,
        TableUtil.cNumber: number,
        TableUtil.cRole: role,
        TableUtil.cCaptain: captain,
        TableUtil.cSort: sort,
        TableUtil.cBall: ball,
        TableUtil.cFoul: foul,
        TableUtil.cDelFlg: delflg,
      };
}
