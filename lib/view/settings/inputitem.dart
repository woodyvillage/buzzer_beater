import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/model/settingedit.dart';
import 'package:buzzer_beater/util/setting.dart';

class InputItem extends StatelessWidget {
  InputItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = Provider.of<ApplicationBloc>(context);
    return ListTile(
      title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder<String>(
            future: getSettingString(SettingUtil.settings[index]),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                );
              } else {
                return Text('');
              }
            },
          ),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: () {
        settingedit(context, _bloc, SettingUtil.settings[index]);
      },
    );
  }
}
