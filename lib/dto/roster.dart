import 'package:buzzer_beater/util/table.dart';

class RosterDto {
  int id;
  int team;
  String name;

  RosterDto({
    this.id,
    this.team,
    this.name,
  });

  factory RosterDto.parse(Map<String, dynamic> _record) => RosterDto(
        id: _record[TableUtil.cId],
        team: _record[TableUtil.cTeam],
        name: _record[TableUtil.cName],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cTeam: team,
        TableUtil.cName: name,
      };

  bool isComplete() {
    if (name == null || team == null) {
      return false;
    } else {
      return true;
    }
  }
}
