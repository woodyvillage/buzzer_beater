import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/advertisement.dart';
import 'package:buzzer_beater/view/team/list.dart';

class TeamBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ApplicationAdvertisement().getBanner(
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TeamsList(),
            ),
          )
        ],
      ),
    );
  }
}
