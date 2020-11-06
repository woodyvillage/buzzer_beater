import 'package:buzzer_beater/util/table.dart';

class RegistDto {
  int id;
  int team;
  int roster;
  int member;
  int number;
  int role;
  int sort;
  int ball;

  RegistDto({
    this.id,
    this.team,
    this.roster,
    this.member,
    this.number,
    this.role,
    this.sort,
    this.ball,
  });

  factory RegistDto.parse(Map<String, dynamic> _record) => RegistDto(
        id: _record[TableUtil.cId],
        team: _record[TableUtil.cTeam],
        roster: _record[TableUtil.cRoster],
        member: _record[TableUtil.cMember],
        number: _record[TableUtil.cNumber],
        role: _record[TableUtil.cRole],
        sort: _record[TableUtil.cSort],
        ball: _record[TableUtil.cBall],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cTeam: team,
        TableUtil.cRoster: roster,
        TableUtil.cMember: member,
        TableUtil.cNumber: number,
        TableUtil.cRole: role,
        TableUtil.cSort: sort,
        TableUtil.cBall: ball,
      };
}
