import 'dart:io';

import 'package:buzzer_beater/util/application.dart';

class ApplicationAdvertisement {
  String getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return ApplicationUtil.liveCode;
    } else if (Platform.isIOS) {
      return null;
    }
    return null;
  }
}
