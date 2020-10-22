import 'package:buzzer_beater/util/table.dart';

class MemberDto {
  int id;
  int team;
  String name;
  int age;
  int jbaid;
  int number;
  int role;
  String image;

  MemberDto({
    this.id,
    this.team,
    this.name,
    this.age,
    this.jbaid,
    this.number,
    this.role,
    this.image,
  });

  factory MemberDto.parse(Map<String, dynamic> _record) => MemberDto(
        id: _record[TableUtil.cId],
        team: _record[TableUtil.cTeam],
        name: _record[TableUtil.cName],
        age: _record[TableUtil.cAge],
        jbaid: _record[TableUtil.cJbaId],
        number: _record[TableUtil.cNumber],
        role: _record[TableUtil.cRole],
        image: _record[TableUtil.cImage],
      );

  Map<String, dynamic> toMap() => {
        TableUtil.cId: id,
        TableUtil.cTeam: team,
        TableUtil.cName: name,
        TableUtil.cAge: age,
        TableUtil.cJbaId: jbaid,
        TableUtil.cNumber: number,
        TableUtil.cRole: role,
        TableUtil.cImage: image,
      };

  bool isComplete() {
    if (team == null || name == null || age == null || jbaid == null) {
      return false;
    } else {
      return true;
    }
  }
}
