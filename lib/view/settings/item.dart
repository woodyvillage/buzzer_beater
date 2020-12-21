import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/settings/textitem.dart';

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
    if (SettingUtil.settings[widget.index][SettingUtil.settingCaption]) {
      if (SettingUtil.settings[widget.index][SettingUtil.settingNote] == null) {
        return Container(
          color: Theme.of(context).dividerColor,
          child: ListTile(
            title: Text(
                SettingUtil.settings[widget.index][SettingUtil.settingTitle]),
          ),
        );
      } else {
        return Container(
          color: Theme.of(context).dividerColor,
          child: ListTile(
            title: Text(
                SettingUtil.settings[widget.index][SettingUtil.settingTitle]),
            subtitle: Text('${_packageInfo.appName}(${_packageInfo.version})'),
          ),
        );
      }
    } else {
      return TextConfig(index: widget.index);
    }
  }
}
