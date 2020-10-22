import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';

class OrderDto implements ExpandableListSection<PlayerDto> {
  bool expanded;
  TeamDto team;
  RosterDto roster;
  List<PlayerDto> players;

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }

  @override
  List<PlayerDto> getItems() {
    return players;
  }
}
