import 'package:buzzer_beater/util/table.dart';

class RecordDto {
  int id;
  int team;
  int roster;
  int match;
  int member;
  int quarter1;
  int quarter2;
  int quarter3;
  int quarter4;
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
    this.quarter1,
    this.quarter2,
    this.quarter3,
    this.quarter4,
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
        quarter1: _record[TableUtil.cQuarter1],
        quarter2: _record[TableUtil.cQuarter2],
        quarter3: _record[TableUtil.cQuarter3],
        quarter4: _record[TableUtil.cQuarter4],
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
        TableUtil.cQuarter1: quarter1,
        TableUtil.cQuarter2: quarter2,
        TableUtil.cQuarter3: quarter3,
        TableUtil.cQuarter4: quarter4,
        TableUtil.cFoul1: foul1,
        TableUtil.cFoul2: foul2,
        TableUtil.cFoul3: foul3,
        TableUtil.cFoul4: foul4,
        TableUtil.cFoul5: foul5,
      };
}
