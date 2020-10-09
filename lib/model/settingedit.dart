import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/dialog.dart';
import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/util/setting.dart';

void settingedit(
    BuildContext _context, ApplicationBloc _bloc, List<Object> _data) async {
  ApplicationPreference _pref = ApplicationPreference();
  dynamic _setting = await _pref.getValue(
    _data[SettingUtil.settingName],
    _data[SettingUtil.settingDefault],
  );
  _setting ??= _data[SettingUtil.settingDefault];

  String _result = await showSingleDialog(
    context: _context,
    title: _data[SettingUtil.settingTitle],
    value: _setting,
  );

  if (_result != _setting) {
    await _pref.setValue(_data[SettingUtil.settingName], _result);
  }
}
