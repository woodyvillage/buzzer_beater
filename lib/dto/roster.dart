import 'package:buzzer_beater/util/table.dart';

class RosterDto {
  int id;
  int match;
  int team;
  int member;
  int number;
  int role;
  int q1;
  int q2;
  int q3;
  int q4;
  String f1;
  String f2;
  String f3;
  String f4;
  String f5;

  RosterDto(
      {this.id,
      this.match,
      this.team,
      this.member,
      this.number,
      this.role,
      this.q1,
      this.q2,
      this.q3,
      this.q4,
      this.f1,
      this.f2,
      this.f3,
      this.f4,
      this.f5});

  factory RosterDto.parse(Map<String, dynamic> _record) => RosterDto(
        id: _record[TableUtil.cId],
        match: _record[TableUtil.cMatch],
        team: _record[TableUtil.cTeam],
        member: _record[TableUtil.cMember],
        number: _record[TableUtil.cNumber],
        role: _record[TableUtil.cRole],
        q1: _record[TableUtil.cQuota1],
        q2: _record[TableUtil.cQuota2],
        q3: _record[TableUtil.cQuota3],
        q4: _record[TableUtil.cQuota4],
        f1: _record[TableUtil.cFoul1],
        f2: _record[TableUtil.cFoul2],
        f3: _record[TableUtil.cFoul3],
        f4: _record[TableUtil.cFoul4],
        f5: _record[TableUtil.cFoul5],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cMatch: match,
        TableUtil.cTeam: team,
        TableUtil.cMember: member,
        TableUtil.cNumber: number,
        TableUtil.cRole: role,
        TableUtil.cQuota1: q1,
        TableUtil.cQuota2: q2,
        TableUtil.cQuota3: q3,
        TableUtil.cQuota4: q4,
        TableUtil.cFoul1: f1,
        TableUtil.cFoul2: f2,
        TableUtil.cFoul3: f3,
        TableUtil.cFoul4: f4,
        TableUtil.cFoul5: f5,
      };
}
