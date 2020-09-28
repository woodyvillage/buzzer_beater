import 'package:buzzer_beater/util/table.dart';

class MatchDto {
  int id;
  String name;
  String place;
  String date;
  String coat;
  int hometeam;
  int awayteam;

  MatchDto({this.id, this.name, this.place, this.date, this.coat, this.hometeam, this.awayteam});

  factory MatchDto.parse(Map<String, dynamic> _record) => MatchDto(
    id: _record[TableUtil.cId],
    name: _record[TableUtil.cName],
    place: _record[TableUtil.cPlace],
    date: _record[TableUtil.cDate],
    coat: _record[TableUtil.cCoat],
    hometeam: _record[TableUtil.cHometeam],
    awayteam: _record[TableUtil.cAwayteam],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cName: this.name,
    TableUtil.cPlace: this.place,
    TableUtil.cDate: this.date,
    TableUtil.cCoat: this.coat,
    TableUtil.cHometeam: this.hometeam,
    TableUtil.cAwayteam: this.awayteam,
  };

  bool isComplete() {
    if (this.name == null || this.date == null || this.hometeam == null || this.awayteam == null) {
      return false;
    } else {
      return true;
    }
  }
}