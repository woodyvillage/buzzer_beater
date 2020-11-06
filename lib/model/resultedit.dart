import 'package:buzzer_beater/common/preference.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/util/application.dart';

final ApplicationPreference _pref = ApplicationPreference();

Future getSetting(List<Object> _settings) async {
  Future<dynamic> _result = await _pref.getValue(_settings[3], _settings[4]);
  _result ??= _settings[4];
  return _result;
}

dynamic getHomeAway(ResultDto _data, int _side, int _type) {
  dynamic _result;
  switch (_type) {
    case ApplicationUtil.teamdata:
      _side == ApplicationUtil.home
          ? _result = _data.home
          : _result = _data.away;
      break;
    case ApplicationUtil.totaldata:
      _side == ApplicationUtil.home
          ? _result = _data.hometotal
          : _result = _data.awaytotal;
      break;
    case ApplicationUtil.perioddata:
      _side == ApplicationUtil.home
          ? _result = _data.homeperiod
          : _result = _data.awayperiod;
      break;
    case ApplicationUtil.playerdata:
      _side == ApplicationUtil.home
          ? _result = _data.homeplayers
          : _result = _data.awayplayers;
      break;
    case ApplicationUtil.progressdata:
      _side == ApplicationUtil.home
          ? _result = _data.homeprogress
          : _result = _data.awayprogress;
      break;
  }
  return _result;
}

bool isPeriod(List<PeriodDto> _data, int _index) {
  int _sum = 0;
  for (int i = 0; i < _data.length; i++) {
    _sum += _data[i].score;
    if (_sum == _index + 1) {
      return true;
    } else if (_sum > _index) {
      break;
    }
  }
  return false;
}
