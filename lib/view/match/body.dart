import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/match/list.dart';

class MatchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: MatchList(),
      ),
    );
  }
}
