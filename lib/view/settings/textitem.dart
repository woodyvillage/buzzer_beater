import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';

class TextConfig extends StatelessWidget {
  TextConfig({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    if (SettingUtil.settings[index][SettingUtil.settingNote] == null) {
      // noteがない形式
      return ListTile(
        title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          print('push b');
        },
      );
    } else {
      // noteがある形式
      return ListTile(
        title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
        subtitle: Text(
          SettingUtil.settings[index][SettingUtil.settingNote],
          style: TextStyle(fontSize: 12),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          print('push c');
        },
      );
    }
  }
}
