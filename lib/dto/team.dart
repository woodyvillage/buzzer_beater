import 'package:buzzer_beater/util/table.dart';

class TeamDto {
  int id;
  String name;
  int majormain;
  int majorshade;
  int minormain;
  int minorshade;
  String image;

  TeamDto(
      {this.id,
      this.name,
      this.majormain,
      this.majorshade,
      this.minormain,
      this.minorshade,
      this.image});

  factory TeamDto.parse(Map<String, dynamic> _record) => TeamDto(
        id: _record[TableUtil.cId],
        name: _record[TableUtil.cName],
        majormain: _record[TableUtil.cMajorMain],
        majorshade: _record[TableUtil.cMajorShade],
        minormain: _record[TableUtil.cMinorMain],
        minorshade: _record[TableUtil.cMinorShade],
        image: _record[TableUtil.cImage],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cName: name,
        TableUtil.cMajorMain: majormain,
        TableUtil.cMajorShade: majorshade,
        TableUtil.cMinorMain: minormain,
        TableUtil.cMinorShade: minorshade,
        TableUtil.cImage: image,
      };

  bool isComplete() {
    if (name == null ||
        majormain == null ||
        majorshade == null ||
        minormain == null ||
        minorshade == null) {
      return false;
    } else {
      return true;
    }
  }
}
