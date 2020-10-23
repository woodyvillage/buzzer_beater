import 'package:buzzer_beater/util/table.dart';

class MatchDto {
  int id;
  String date;
  String name;
  String place;
  String coat;
  int hometeam;
  int awayteam;
  int homeroster;
  int awayroster;
  int homeware;
  int awayware;

  MatchDto({
    this.id,
    this.date,
    this.name,
    this.place,
    this.coat,
    this.hometeam,
    this.awayteam,
    this.homeroster,
    this.awayroster,
    this.homeware,
    this.awayware,
  });

  factory MatchDto.parse(Map<String, dynamic> _record) => MatchDto(
        id: _record[TableUtil.cId],
        date: _record[TableUtil.cDate],
        name: _record[TableUtil.cName],
        place: _record[TableUtil.cPlace],
        coat: _record[TableUtil.cCoat],
        hometeam: _record[TableUtil.cHometeam],
        awayteam: _record[TableUtil.cAwayteam],
        homeroster: _record[TableUtil.cHomeroster],
        awayroster: _record[TableUtil.cAwayroster],
        homeware: _record[TableUtil.cHomeware],
        awayware: _record[TableUtil.cAwayware],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cDate: date,
        TableUtil.cName: name,
        TableUtil.cPlace: place,
        TableUtil.cCoat: coat,
        TableUtil.cHometeam: hometeam,
        TableUtil.cAwayteam: awayteam,
        TableUtil.cHomeroster: homeroster,
        TableUtil.cAwayroster: awayroster,
        TableUtil.cHomeware: homeware,
        TableUtil.cAwayware: awayware,
      };
}
