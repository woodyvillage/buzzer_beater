import 'package:buzzer_beater/util/table.dart';

class TeamDto {
  int id;
  String name;
  int majormain;
  int majorshade;
  int minormain;
  int minorshade;

  TeamDto({this.id, this.name, this.majormain, this.majorshade, this.minormain, this.minorshade});

  factory TeamDto.parse(Map<String, dynamic> _record) => TeamDto(
    id: _record[TableUtil.cId],
    name: _record[TableUtil.cName],
    majormain: _record[TableUtil.cMajorMain],
    majorshade: _record[TableUtil.cMajorShade],
    minormain: _record[TableUtil.cMinorMain],
    minorshade: _record[TableUtil.cMinorShade],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cName: this.name,
    TableUtil.cMajorMain: this.majormain,
    TableUtil.cMajorShade: this.majorshade,
    TableUtil.cMinorMain: this.minormain,
    TableUtil.cMinorShade: this.minorshade,
  };

  bool isComplete() {
    if (this.name == null || this.majormain == null || this.majorshade == null || this.minormain == null || this.minorshade == null) {
      return false;
    } else {
      return true;
    }
  }
}