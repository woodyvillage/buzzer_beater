import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/contents/header.dart';
import 'package:buzzer_beater/view/settings/list.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: ApplicationHeader(isView: false),
        body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SettingList()
      ),
    );
  }
}