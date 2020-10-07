import 'package:buzzer_beater/util/table.dart';

class MatchDto {
  int id;
  String name;
  String place;
  String date;
  String coat;
  int hometeam;
  int awayteam;
  int homemain;
  int homeshade;
  int awaymain;
  int awayshade;

  MatchDto(
      {this.id,
      this.name,
      this.place,
      this.date,
      this.coat,
      this.hometeam,
      this.awayteam,
      this.homemain,
      this.homeshade,
      this.awaymain,
      this.awayshade});

  factory MatchDto.parse(Map<String, dynamic> _record) => MatchDto(
        id: _record[TableUtil.cId],
        name: _record[TableUtil.cName],
        place: _record[TableUtil.cPlace],
        date: _record[TableUtil.cDate],
        coat: _record[TableUtil.cCoat],
        hometeam: _record[TableUtil.cHometeam],
        awayteam: _record[TableUtil.cAwayteam],
        homemain: _record[TableUtil.cHomeMain],
        homeshade: _record[TableUtil.cHomeShade],
        awaymain: _record[TableUtil.cAwayMain],
        awayshade: _record[TableUtil.cAwayShade],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cName: name,
        TableUtil.cPlace: place,
        TableUtil.cDate: date,
        TableUtil.cCoat: coat,
        TableUtil.cHometeam: hometeam,
        TableUtil.cAwayteam: awayteam,
        TableUtil.cHomeMain: homemain,
        TableUtil.cHomeShade: homeshade,
        TableUtil.cAwayMain: awaymain,
        TableUtil.cAwayShade: awayshade,
      };

  bool isComplete() {
    if (name == null ||
        date == null ||
        hometeam == null ||
        awayteam == null ||
        homemain == null ||
        homeshade == null ||
        awaymain == null ||
        awayshade == null) {
      return false;
    } else {
      return true;
    }
  }
}
