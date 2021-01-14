import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/model/settingedit.dart';
import 'package:buzzer_beater/util/setting.dart';

class DialogItem extends StatelessWidget {
  DialogItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = Provider.of<ApplicationBloc>(context);
    return ListTile(
      title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
      trailing: RaisedButton(
        child: Text(SettingUtil.settings[index][SettingUtil.settingName]),
        onPressed: () {
          if (index == SettingUtil.initialize) {
            settingmessage(context, _bloc, SettingUtil.settings[index]);
          } else if (index == SettingUtil.charges) {
            settingapproval(context, _bloc, SettingUtil.settings[index]);
          }
        },
        highlightElevation: 16,
        highlightColor: Colors.blue,
        onHighlightChanged: (value) {},
      ),
    );
  }
}
