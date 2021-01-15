import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/application.dart';

class ApplicationAdvertisement {
  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      // return ApplicationUtil.testCode;
      return ApplicationUtil.liveCode;
    } else if (Platform.isIOS) {
      return null;
    }
    return null;
  }

  bool _isVisible(int _index, int _interval) {
    if (_getBannerAdUnitId() != ApplicationUtil.liveCode) {
      return false;
    }

    return _index == null && _interval == null
        ? true
        : _index % _interval == 0
            ? true
            : false;
  }

  Widget getBanner({
    @required double width,
    @required bool purchase,
    int index,
    int interval,
  }) {
    if (_isVisible(index, interval)) {
      if (!purchase) {
        return AdmobBanner(
          adUnitId: _getBannerAdUnitId(),
          adSize: AdmobBannerSize.ADAPTIVE_BANNER(
            width: width.toInt(),
          ),
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
