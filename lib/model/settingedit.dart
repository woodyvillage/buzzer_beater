import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/dialog.dart';
import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/util/setting.dart';

Future<String> getSettingString(List<Object> _data) async {
  ApplicationPreference _pref = ApplicationPreference();
  dynamic _setting = await _pref.getValue(
    _data[SettingUtil.settingName],
    _data[SettingUtil.settingDefault],
  );
  _setting ??= _data[SettingUtil.settingDefault];

  return _setting;
}

void settingedit(
    BuildContext _context, ApplicationBloc _bloc, List<Object> _data) async {
  ApplicationPreference _pref = ApplicationPreference();
  String _setting = await getSettingString(_data);
  String _result = await showSingleDialog(
    context: _context,
    title: _data[SettingUtil.settingTitle],
    value: _setting,
  );

  if (_result != _setting) {
    await _pref.setValue(_data[SettingUtil.settingName], _result);
  }
}

void settingmessage(
    BuildContext _context, ApplicationBloc _bloc, List<Object> _data) async {
  ApplicationPreference _pref = ApplicationPreference();
  bool _result = await showMessageDialog(
    context: _context,
    title: _data[SettingUtil.settingName],
    value: _data[SettingUtil.settingDefault],
  );

  if (_result != null) {
    if (_result) {
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.fieldgoal][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.fieldgoal]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.freethrow][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.freethrow]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.owngoal][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.owngoal]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.periodend][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.periodend]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.timeout][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.timeout]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.nottimeout][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.nottimeout]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.teamfoul][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.teamfoul]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.notteamfoul]
              [SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.notteamfoul]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.notfoul][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.notfoul]
              [SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.play][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.play][SettingUtil.settingDefault]);
      await _pref.setValue(
          SettingUtil.settings[SettingUtil.change][SettingUtil.settingName],
          SettingUtil.settings[SettingUtil.change][SettingUtil.settingDefault]);
    }
  }
}
