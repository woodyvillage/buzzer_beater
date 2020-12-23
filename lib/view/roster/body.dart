import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/advertisement.dart';
import 'package:buzzer_beater/view/roster/list.dart';

class RosterBody extends StatelessWidget {
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
              child: RostersList(),
            ),
          )
        ],
      ),
    );
  }
}
