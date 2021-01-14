import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/settings/captionitem.dart';
import 'package:buzzer_beater/view/settings/dialogitem.dart';
import 'package:buzzer_beater/view/settings/inputitem.dart';

class SettingItem extends StatefulWidget {
  SettingItem({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _item;
    switch (SettingUtil.settings[widget.index][SettingUtil.settingType]) {
      case 'CAP':
        _item = CaptionItem(index: widget.index);
        break;
      case 'INP':
        _item = InputItem(index: widget.index);
        break;
      case 'DLG':
        _item = DialogItem(index: widget.index);
        break;
      case 'APL':
        _item = Container(
          child: ListTile(
            title: Text(
                SettingUtil.settings[widget.index][SettingUtil.settingTitle]),
            subtitle: Text('${_packageInfo.appName}'),
          ),
        );
        break;
      case 'VER':
        _item = Container(
          child: ListTile(
            title: Text(
                SettingUtil.settings[widget.index][SettingUtil.settingTitle]),
            subtitle: Text('${_packageInfo.version}'),
          ),
        );
        break;
      default:
        _item = Container();
    }
    return _item;
  }
}
