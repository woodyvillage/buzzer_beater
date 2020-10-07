import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/setting.dart';

class SwitchConfig extends StatefulWidget {
  SwitchConfig({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _SwitchConfigState createState() => _SwitchConfigState();
}

class _SwitchConfigState extends State<SwitchConfig> {
  bool _switchValue = true;

  @override
  void initState() {
    super.initState();
    _getPreference();
  }

  _getPreference() async {
    // _switchValue = await getSettingByIndex(widget.index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _switchValue,
      title: Text(SettingUtil.settings[widget.index][SettingUtil.settingTitle]),
      subtitle:
          Text(SettingUtil.settings[widget.index][SettingUtil.settingNote]),
      onChanged: (bool value) {
        setState(() {
          // _switchValue = value;
          // updSetting(widget.index, _switchValue);
          // context.read<SettingNotifier>().changeMode();
        });
      },
    );
  }
}
