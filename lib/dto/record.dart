import 'package:buzzer_beater/util/table.dart';

class RecordDto {
  int id;
  int team;
  int roster;
  int match;
  int member;
  int quota1;
  int quota2;
  int quota3;
  int quota4;
  String foul1;
  String foul2;
  String foul3;
  String foul4;
  String foul5;

  RecordDto({
    this.id,
    this.team,
    this.roster,
    this.match,
    this.member,
    this.quota1,
    this.quota2,
    this.quota3,
    this.quota4,
    this.foul1,
    this.foul2,
    this.foul3,
    this.foul4,
    this.foul5,
  });

  factory RecordDto.parse(Map<String, dynamic> _record) => RecordDto(
        id: _record[TableUtil.cId],
        team: _record[TableUtil.cTeam],
        roster: _record[TableUtil.cRoster],
        match: _record[TableUtil.cMatch],
        member: _record[TableUtil.cMember],
        quota1: _record[TableUtil.cQuota1],
        quota2: _record[TableUtil.cQuota2],
        quota3: _record[TableUtil.cQuota3],
        quota4: _record[TableUtil.cQuota4],
        foul1: _record[TableUtil.cFoul1],
        foul2: _record[TableUtil.cFoul2],
        foul3: _record[TableUtil.cFoul3],
        foul4: _record[TableUtil.cFoul4],
        foul5: _record[TableUtil.cFoul5],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cTeam: team,
        TableUtil.cRoster: roster,
        TableUtil.cMatch: match,
        TableUtil.cMember: member,
        TableUtil.cQuota1: quota1,
        TableUtil.cQuota2: quota2,
        TableUtil.cQuota3: quota3,
        TableUtil.cQuota4: quota4,
        TableUtil.cFoul1: foul1,
        TableUtil.cFoul2: foul2,
        TableUtil.cFoul3: foul3,
        TableUtil.cFoul4: foul4,
        TableUtil.cFoul5: foul5,
      };
}
