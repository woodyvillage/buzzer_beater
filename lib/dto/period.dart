import 'package:buzzer_beater/util/table.dart';

class PeriodDto {
  int id;
  int match;
  int team;
  int period;
  int score;
  int timeout;
  int teamfoul;
  int status;

  PeriodDto({
    this.id,
    this.match,
    this.team,
    this.period,
    this.score,
    this.timeout,
    this.teamfoul,
    this.status,
  });

  factory PeriodDto.parse(Map<String, dynamic> _record) => PeriodDto(
        id: _record[TableUtil.cId],
        match: _record[TableUtil.cMatch],
        team: _record[TableUtil.cTeam],
        period: _record[TableUtil.cPeriod],
        score: _record[TableUtil.cScore],
        timeout: _record[TableUtil.cTimeout],
        teamfoul: _record[TableUtil.cTeamfoul],
        status: _record[TableUtil.cStatus],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cMatch: match,
        TableUtil.cTeam: team,
        TableUtil.cPeriod: period,
        TableUtil.cScore: score,
        TableUtil.cTimeout: timeout,
        TableUtil.cTeamfoul: teamfoul,
        TableUtil.cStatus: status,
      };
}
