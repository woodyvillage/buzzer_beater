import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/team.dart';

class TeamMateDto implements ExpandableListSection<MemberDto> {
  bool expanded;
  List<MemberDto> members;
  TeamDto team;

  @override
  List<MemberDto> getItems() {
    return members;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}
