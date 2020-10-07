import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/settings/switchitem.dart';
import 'package:buzzer_beater/view/settings/textitem.dart';

class SettingItem extends StatelessWidget {
  SettingItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    if (SettingUtil.settings[index][SettingUtil.settingCaption]) {
      return Container(
        color: Theme.of(context).dividerColor,
        child: ListTile(
          title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
        ),
      );
    } else {
      if (SettingUtil.settings[index][SettingUtil.settingDefault] is bool) {
        return SwitchConfig(index: index);
      } else {
        return TextConfig(index: index);
      }
    }
  }
}
