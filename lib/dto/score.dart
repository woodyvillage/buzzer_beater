import 'package:buzzer_beater/util/table.dart';

class ScoreDto {
  int id;
  int match;
  int team;
  int period;
  int point;
  int score;
  int member;

  ScoreDto({
    this.id,
    this.match,
    this.team,
    this.period,
    this.point,
    this.score,
    this.member,
  });

  factory ScoreDto.parse(Map<String, dynamic> _record) => ScoreDto(
        id: _record[TableUtil.cId],
        match: _record[TableUtil.cMatch],
        team: _record[TableUtil.cTeam],
        period: _record[TableUtil.cPeriod],
        point: _record[TableUtil.cPoint],
        score: _record[TableUtil.cScore],
        member: _record[TableUtil.cMember],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cMatch: match,
        TableUtil.cTeam: team,
        TableUtil.cPeriod: period,
        TableUtil.cPoint: point,
        TableUtil.cScore: score,
        TableUtil.cMember: member,
      };
}
