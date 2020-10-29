import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/util/setting.dart';

final ApplicationPreference _pref = ApplicationPreference();

class SettingDao {
  Future<SettingDto> getAllPrefereces(List<List<Object>> _settings) async {
    SettingDto _setting = SettingDto();

    _setting.fieldgoal = await _getPref(SettingUtil.fieldgoal);
    _setting.freethrow = await _getPref(SettingUtil.freethrow);
    _setting.owngoal = await _getPref(SettingUtil.owngoal);
    _setting.periodend = await _getPref(SettingUtil.periodend);
    _setting.timeout = await _getPref(SettingUtil.timeout);
    _setting.nottimeout = await _getPref(SettingUtil.nottimeout);
    _setting.teamfoul = await _getPref(SettingUtil.teamfoul);
    _setting.notteamfoul = await _getPref(SettingUtil.notteamfoul);
    _setting.notfoul = await _getPref(SettingUtil.notfoul);
    _setting.play = await _getPref(SettingUtil.play);
    _setting.change = await _getPref(SettingUtil.change);

    return _setting;
  }

  dynamic _getPref(int _index) async {
    dynamic _value = await _pref.getValue(
      SettingUtil.settings[_index][SettingUtil.settingName],
      SettingUtil.settings[_index][SettingUtil.settingDefault],
    );
    _value ??= SettingUtil.settings[_index][SettingUtil.settingDefault];
    return _value;
  }
}
