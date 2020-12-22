import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:buzzer_beater/common/advertisement.dart';
import 'package:buzzer_beater/view/roster/list.dart';

class RosterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AdmobBanner(
            adUnitId: ApplicationAdvertisement().getBannerAdUnitId(),
            adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              width: MediaQuery.of(context).size.width.toInt(),
            ),
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
