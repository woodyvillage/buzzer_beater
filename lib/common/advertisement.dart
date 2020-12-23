import 'dart:io';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:buzzer_beater/util/application.dart';

class ApplicationAdvertisement {
  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return ApplicationUtil.liveCode;
    } else if (Platform.isIOS) {
      return null;
    }
    return null;
  }

  bool _isVisible(int _index, int _interval) {
    if (_index == null || _interval == null) {
      return true;
    } else {
      if (_index % _interval == 0) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget getBanner({
    @required double width,
    int index,
    int interval,
  }) {
    if (_isVisible(index, interval)) {
      return AdmobBanner(
        adUnitId: _getBannerAdUnitId(),
        adSize: AdmobBannerSize.ADAPTIVE_BANNER(
          width: width.toInt(),
        ),
      );
    } else {
      return Container();
    }
  }
}
