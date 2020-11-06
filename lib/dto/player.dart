class PlayerDto {
  int team;
  int roster;
  int member;
  int number;
  int role;
  int sort;
  String name;
  int age;
  int jbaid;
  String image;
  List<int> quarter;
  List<String> foul;

  PlayerDto({
    this.team,
    this.roster,
    this.member,
    this.number,
    this.role,
    this.sort,
    this.name,
    this.age,
    this.jbaid,
    this.image,
    this.quarter,
    this.foul,
  });
}
