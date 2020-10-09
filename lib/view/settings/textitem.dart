import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/model/settingedit.dart';
import 'package:buzzer_beater/util/setting.dart';

class TextConfig extends StatelessWidget {
  TextConfig({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = Provider.of<ApplicationBloc>(context);
    if (SettingUtil.settings[index][SettingUtil.settingNote] == null) {
      // noteがない形式
      return ListTile(
        title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          settingedit(context, _bloc, SettingUtil.settings[index]);
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
        onTap: () async {
          settingedit(context, _bloc, SettingUtil.settings[index]);
        },
      );
    }
  }
}
