import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/model/settingedit.dart';
import 'package:buzzer_beater/util/setting.dart';

class DialogItem extends StatelessWidget {
  DialogItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = Provider.of<ApplicationBloc>(context);
    bool _isInvalidAds = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.isInvalidAds);
    dynamic _purchase = context.select(
        (PurchaseNotifier purchaseNotifier) => purchaseNotifier.purchaseList);

    return ListTile(
      title: Text(SettingUtil.settings[index][SettingUtil.settingTitle]),
      trailing: RaisedButton(
        child: Text(SettingUtil.settings[index][SettingUtil.settingName]),
        onPressed: _isInvalidAds
            ? null
            : () async {
                await settingapproval(
                    context, _bloc, SettingUtil.settings[index], _purchase[0]);
                Navigator.pop(context);
              },
        highlightElevation: 16,
        highlightColor: Colors.blueGrey,
        disabledColor: Colors.grey[500],
        onHighlightChanged: (value) {},
      ),
    );
  }
}
