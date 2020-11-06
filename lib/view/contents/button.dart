import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/view/match/form.dart';
import 'package:buzzer_beater/view/member/form.dart';
import 'package:buzzer_beater/view/roster/form.dart';
import 'package:buzzer_beater/view/team/form.dart';
import 'package:buzzer_beater/model/test.dart';

class ApplicationFloat extends StatelessWidget {
  ApplicationFloat({Key key, this.index}) : super(key: key);
  final int index;

  dispatch(BuildContext context, int index) {
    MaterialPageRoute teamPageRoute = MaterialPageRoute(
      builder: (context) => TeamForm(edit: false),
    );
    MaterialPageRoute memberPageRoute = MaterialPageRoute(
      builder: (context) => MemberForm(edit: false),
    );
    MaterialPageRoute rosterPageRoute = MaterialPageRoute(
      builder: (context) => RosterForm(edit: false),
    );
    MaterialPageRoute rosterPageMatch = MaterialPageRoute(
      builder: (context) => MatchForm(edit: false),
    );
    switch (index) {
      case routesetTeam:
        Navigator.push(
          context,
          teamPageRoute,
        );
        break;
      case routesetMember:
        Navigator.push(
          context,
          memberPageRoute,
        );
        break;
      case routesetRoster:
        Navigator.push(
          context,
          rosterPageRoute,
        );
        break;
      case routesetMatch:
        Navigator.push(
          context,
          rosterPageMatch,
        );
        break;
      case routesetResult:
        test();
        test2();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: routesetFloatIcon[index],
      label: routesetFloatText[index],
      onPressed: () {
        dispatch(context, index);
      },
    );
  }
}
