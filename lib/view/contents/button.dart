import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/view/member/form.dart';
import 'package:buzzer_beater/view/team/form.dart';

class ApplicationFloat extends StatelessWidget {
  ApplicationFloat({Key key, this.index}) : super(key: key);
  final int index;

  dispatch(BuildContext context, int index) {
    switch (index) {
      case routesetTeam:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TeamForm()),
        );
        break;
      case routesetMember:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberForm()),
        );
        break;
      default:
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