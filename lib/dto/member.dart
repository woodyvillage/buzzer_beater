import 'package:buzzer_beater/util/table.dart';

class MemberDto {
  int id;
  int team;
  String name;
  int age;
  int regist;
  int number;
  String image;

  MemberDto({this.id, this.team, this.name, this.age, this.regist, this.number, this.image});

  factory MemberDto.parse(Map<String, dynamic> _record) => MemberDto(
    id: _record[TableUtil.cId],
    team: _record[TableUtil.cTeam],
    name: _record[TableUtil.cName],
    age: _record[TableUtil.cAge],
    regist: _record[TableUtil.cRegist],
    number: _record[TableUtil.cNumber],
    image: _record[TableUtil.cImage],
  );

  Map<String, dynamic> toMap() => {
    TableUtil.cId: this.id,
    TableUtil.cTeam: this.team,
    TableUtil.cName: this.name,
    TableUtil.cAge: this.age,
    TableUtil.cRegist: this.regist,
    TableUtil.cNumber: this.number,
    TableUtil.cImage: this.image,
  };

  bool isComplete() {
    if (this.team == null || this.name == null || this.age == null || this.regist == null) {
      return false;
    } else {
      return true;
    }
  }
}