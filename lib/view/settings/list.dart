import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/settings/item.dart';

class SettingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: SettingUtil.settings.length,
        itemBuilder: (context, index) {
          return SettingItem(index: index);
        },
      ),
    );
  }
}
