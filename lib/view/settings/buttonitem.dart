import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/purchases/body.dart';

class ButtonItem extends StatelessWidget {
  ButtonItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
      trailing: RaisedButton(
        child: Text(SettingUtil.settings[index][SettingUtil.settingName]),
        onPressed: () {
          MaterialPageRoute purchasePageRoute = MaterialPageRoute(
            builder: (context) => PurchasePanel(),
          );
          Navigator.push(
            context,
            purchasePageRoute,
          );
        },
        highlightElevation: 16,
        highlightColor: Colors.blue,
        onHighlightChanged: (value) {},
      ),
    );
  }
}
