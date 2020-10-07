import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/util/setting.dart';

final ApplicationPreference _pref = ApplicationPreference();

class SettingDao {
  Future<SettingDto> getAllPrefereces(List<List<Object>> _settings) async {
    SettingDto _setting = SettingDto();

    _setting.fieldGoal = await _pref.getValue(
        _settings[1][SettingUtil.settingName],
        _settings[1][SettingUtil.settingDefault]);
    _setting.fieldGoal ??= _settings[1][SettingUtil.settingDefault];

    _setting.freeThrow = await _pref.getValue(
        _settings[2][SettingUtil.settingName],
        _settings[2][SettingUtil.settingDefault]);
    _setting.freeThrow ??= _settings[2][SettingUtil.settingDefault];

    _setting.ownGoal = await _pref.getValue(
        _settings[3][SettingUtil.settingName],
        _settings[3][SettingUtil.settingDefault]);
    _setting.ownGoal ??= _settings[3][SettingUtil.settingDefault];

    _setting.periodend = await _pref.getValue(
        _settings[4][SettingUtil.settingName],
        _settings[4][SettingUtil.settingDefault]);
    _setting.periodend ??= _settings[4][SettingUtil.settingDefault];

    _setting.timeout = await _pref.getValue(
        _settings[6][SettingUtil.settingName],
        _settings[6][SettingUtil.settingDefault]);
    _setting.timeout ??= _settings[6][SettingUtil.settingDefault];

    _setting.nottimeout = await _pref.getValue(
        _settings[7][SettingUtil.settingName],
        _settings[7][SettingUtil.settingDefault]);
    _setting.nottimeout ??= _settings[7][SettingUtil.settingDefault];

    _setting.teamfoul = await _pref.getValue(
        _settings[9][SettingUtil.settingName],
        _settings[9][SettingUtil.settingDefault]);
    _setting.teamfoul ??= _settings[9][SettingUtil.settingDefault];

    _setting.notteamfoul = await _pref.getValue(
        _settings[10][SettingUtil.settingName],
        _settings[10][SettingUtil.settingDefault]);
    _setting.notteamfoul ??= _settings[10][SettingUtil.settingDefault];

    _setting.notfoul = await _pref.getValue(
        _settings[12][SettingUtil.settingName],
        _settings[12][SettingUtil.settingDefault]);
    _setting.notfoul ??= _settings[12][SettingUtil.settingDefault];

    _setting.play = await _pref.getValue(_settings[15][SettingUtil.settingName],
        _settings[15][SettingUtil.settingDefault]);
    _setting.play ??= _settings[15][SettingUtil.settingDefault];

    _setting.change = await _pref.getValue(
        _settings[16][SettingUtil.settingName],
        _settings[16][SettingUtil.settingDefault]);
    _setting.change ??= _settings[16][SettingUtil.settingDefault];
    return _setting;
  }
}
