import 'package:buzzer_beater/util/table.dart';

class OfficialDto {
  int id;
  String crewchief;
  String umpire;
  String scorer;
  String asst;
  String timer;
  String half;

  OfficialDto({this.id, this.crewchief, this.umpire, this.scorer, this.asst, this.timer, this.half});

  factory OfficialDto.parse(Map<String, dynamic> _record) => OfficialDto(
    id: _record[TableUtil.cId],
    crewchief: _record[TableUtil.cCrewchief],
    umpire: _record[TableUtil.cUmpire],
    scorer: _record[TableUtil.cScorer],
    asst: _record[TableUtil.cAsst],
    timer: _record[TableUtil.cTimer],
    half: _record[TableUtil.cHalf],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cCrewchief: this.crewchief,
    TableUtil.cUmpire: this.umpire,
    TableUtil.cScorer: this.scorer,
    TableUtil.cAsst: this.asst,
    TableUtil.cTimer: this.timer,
    TableUtil.cHalf: this.half,
  };
}