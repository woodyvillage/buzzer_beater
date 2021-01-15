import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/advertisement.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/view/member/list.dart';

class MemberBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isInvalidAds = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.isInvalidAds);

    return SafeArea(
      child: Column(
        children: [
          ApplicationAdvertisement().getBanner(
            width: MediaQuery.of(context).size.width,
            purchase: _isInvalidAds,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: MembersList(),
            ),
          )
        ],
      ),
    );
  }
}
