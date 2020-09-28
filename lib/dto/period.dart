import 'package:buzzer_beater/util/table.dart';

class PeriodDto {
  int id;
  int match;
  int team;
  int number;
  int score;

  PeriodDto({this.id, this.match, this.team, this.number, this.score});

  factory PeriodDto.parse(Map<String, dynamic> _record) => PeriodDto(
    id: _record[TableUtil.cId],
    match: _record[TableUtil.cMatch],
    team: _record[TableUtil.cTeam],
    number: _record[TableUtil.cNumber],
    score: _record[TableUtil.cScore],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cMatch: this.match,
    TableUtil.cTeam: this.team,
    TableUtil.cNumber: this.number,
    TableUtil.cScore: this.score,
  };

  bool isComplete() {
    if (this.match == null || this.team == null || this.number == null || this.score == null) {
      return false;
    } else {
      return true;
    }
  }
}