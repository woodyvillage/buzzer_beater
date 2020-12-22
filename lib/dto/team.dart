import 'package:buzzer_beater/util/table.dart';

class TeamDto {
  int id;
  String name;
  int homeMain;
  int homeEdge;
  int awayMain;
  int awayEdge;
  String image;
  int owner;
  int delflg;

  TeamDto({
    this.id,
    this.name,
    this.homeMain,
    this.homeEdge,
    this.awayMain,
    this.awayEdge,
    this.image,
    this.owner,
    this.delflg,
  });

  factory TeamDto.parse(Map<String, dynamic> _record) => TeamDto(
        id: _record[TableUtil.cId],
        name: _record[TableUtil.cName],
        homeMain: _record[TableUtil.cHomeMain],
        homeEdge: _record[TableUtil.cHomeEdge],
        awayMain: _record[TableUtil.cAwayMain],
        awayEdge: _record[TableUtil.cAwayEdge],
        image: _record[TableUtil.cImage],
        owner: _record[TableUtil.cOwner],
        delflg: _record[TableUtil.cDelFlg],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cName: name,
        TableUtil.cHomeMain: homeMain,
        TableUtil.cHomeEdge: homeEdge,
        TableUtil.cAwayMain: awayMain,
        TableUtil.cAwayEdge: awayEdge,
        TableUtil.cImage: image,
        TableUtil.cOwner: owner,
        TableUtil.cDelFlg: delflg,
      };

  bool isComplete() {
    if (name == null ||
        homeMain == null ||
        homeEdge == null ||
        awayMain == null ||
        awayEdge == null) {
      return false;
    } else {
      return true;
    }
  }
}
