import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';

class CaptionItem extends StatelessWidget {
  CaptionItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor,
      child: ListTile(
        title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
      ),
    );
  }
}
