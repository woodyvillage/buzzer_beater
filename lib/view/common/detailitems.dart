import 'dart:io';
import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/bench.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/result.dart';
import 'package:buzzer_beater/util/setting.dart';

Widget _filler(int _flex) {
  return Expanded(
    flex: _flex,
    child: SizedBox(),
  );
}

Widget runningScoreSubSet({
  @required ResultDto data,
  @required int index,
  @required SettingDto setting,
}) {
  List<PeriodDto> _homeperiod =
      getHomeAway(data, ResultUtil.home, ResultUtil.period);
  List<PeriodDto> _awayperiod =
      getHomeAway(data, ResultUtil.away, ResultUtil.period);
  List<ScoreProgressDto> _homeprogress =
      getHomeAway(data, ResultUtil.home, ResultUtil.progress);
  List<ScoreProgressDto> _awayprogress =
      getHomeAway(data, ResultUtil.away, ResultUtil.progress);

  return Row(
    children: <Widget>[
      _filler(2),
      _imageItem(_homeprogress[index], 30),
      _filler(2),
      _nameItem(_homeprogress[index], Alignment.centerLeft),
      _pointedItem(_homeperiod, _homeprogress, data.hometotal, index, setting),
      _scoreItem(_homeperiod, _homeprogress, data.hometotal, index, setting),
      _scoreItem(_awayperiod, _awayprogress, data.awaytotal, index, setting),
      _pointedItem(_awayperiod, _awayprogress, data.awaytotal, index, setting),
      _nameItem(_awayprogress[index], Alignment.centerRight),
      _filler(2),
      _imageItem(_awayprogress[index], 30),
      _filler(2),
    ],
  );
}

Widget _scoreItem(List<PeriodDto> _period, List<ScoreProgressDto> _progress,
    int _total, int _index, SettingDto _setting) {
  var _decoration = _scoreDecorationItem(_period, _total, _index);
  return Expanded(
    flex: 5,
    child: Container(
      height: 50,
      decoration: _decoration,
      alignment: Alignment.center,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Text((_index + 1).toString()),
          _splitePointItem(_progress[_index], _setting),
          _splitePeriodItem(_period, _index, _setting),
        ],
      ),
    ),
  );
}

BoxDecoration _scoreDecorationItem(
    List<PeriodDto> _data, int _total, int _index) {
  var period = isPeriod(_data, _index);
  if (period) {
    return BoxDecoration(
        border: Border(
      bottom: BorderSide(
        color: Colors.black,
        width: 4,
      ),
      top: BorderSide(
        color: Colors.black,
        width: 0,
      ),
      left: BorderSide(
        color: Colors.black,
        width: 0,
      ),
      right: BorderSide(
        color: Colors.black,
        width: 0,
      ),
    ));
  } else {
    if (_total < _index + 1) {
      return BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.black, width: 0),
      );
    } else {
      return BoxDecoration(
        border: Border.all(color: Colors.black, width: 0),
      );
    }
  }
}

Widget _splitePointItem(ScoreProgressDto _data, SettingDto _setting) {
  var _mark = '';
  switch (_data.point) {
    case ResultUtil.fieldgoal:
      _mark = _setting.fieldGoal;
      break;
    case ResultUtil.freethrow:
      _mark = _setting.freeThrow;
      break;
    default:
  }
  return Text(
    _mark,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
  );
}

Widget _splitePeriodItem(
    List<PeriodDto> _data, int _index, SettingDto _setting) {
  var _now = 0;
  var _mark = '';
  for (int i = 0; i < _data.length; i++) {
    _now += _data[i].score;
    if (_now == _index + 1) {
      _mark = _setting.periodend;
    } else if (_now > _index) {
      break;
    }
  }
  return Text(
    _mark,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 29,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _pointedItem(List<PeriodDto> _period, List<ScoreProgressDto> _progress,
    int _total, int _index, SettingDto _setting) {
  var _decoration = _scoreDecorationItem(_period, _total, _index);
  var _mark = '';
  if (_progress[_index].number != null && _progress[_index].number < 0) {
    _mark = _setting.ownGoal;
  } else {
    _mark = _progress[_index].point == null
        ? ''
        : _progress[_index].number.toString();
  }
  return Expanded(
    flex: 5,
    child: Container(
      height: 50,
      decoration: _decoration,
      alignment: Alignment.center,
      child: Text(_mark),
    ),
  );
}

Widget _nameItem(dynamic _data, Alignment _alignment) {
  var _name = _data.name == null ? '' : _data.name;
  return Expanded(
    flex: 20,
    child: Container(
      alignment: _alignment,
      child: Text(
        _name,
        textAlign: TextAlign.end,
      ),
    ),
  );
}

Widget _imageItem(dynamic _data, double _size) {
  if (_data.image == null) {
    return Expanded(
      flex: 6,
      child: Container(),
    );
  } else {
    if (_data.image == 'null') {
      return Expanded(
        flex: 6,
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('images/noimage.png'),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 6,
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: FileImage(File(_data.image)),
            ),
          ),
        ),
      );
    }
  }
}

Widget teamHeaderSubSet() {
  return Row(
    children: <Widget>[
      _filler(5),
      Expanded(
        flex: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text('タイムアウト'),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text('チームファウル'),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text('チームファウル'),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      _filler(2),
    ],
  );
}

Widget teamIndexSubSet() {
  return Row(
    children: <Widget>[
      _filler(5),
      _indexItem(SettingUtil.indexchar[0]),
      _indexItem(SettingUtil.indexchar[1]),
      _indexItem(SettingUtil.indexchar[2]),
      _indexItem(SettingUtil.indexchar[3]),
      _indexItem(SettingUtil.indexchar[4]),
      _indexItem(SettingUtil.indexchar[5]),
      _indexItem(SettingUtil.indexchar[6]),
      _indexItem(SettingUtil.indexchar[7]),
      _indexItem(SettingUtil.indexchar[8]),
      _indexItem(SettingUtil.indexchar[9]),
      _indexItem(SettingUtil.indexchar[5]),
      _indexItem(SettingUtil.indexchar[6]),
      _indexItem(SettingUtil.indexchar[7]),
      _indexItem(SettingUtil.indexchar[8]),
      _indexItem(SettingUtil.indexchar[9]),
      _filler(2),
    ],
  );
}

Widget _indexItem(String _setting) {
  return Expanded(
    flex: 5,
    child: Container(
      alignment: Alignment.center,
      child: Text(_setting),
      height: 25,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget teamSheetSubSet({
  @required ResultDto data,
  @required int side,
  @required SettingDto setting,
  @required bool timeout,
}) {
  List<PeriodDto> _period = getHomeAway(data, side, ResultUtil.period);
  var _switch = _period.length == 4
      ? _quotaItem(setting.nottimeout)
      : _timeoutItem(_period[4], setting);
  if (timeout) {
    return Row(
      children: <Widget>[
        _filler(5),
        _timeoutItem(_period[0], setting),
        _timeoutItem(_period[1], setting),
        _timeoutItem(_period[2], setting),
        _timeoutItem(_period[3], setting),
        _switch,
        _quotaItem('1Q'),
        _teamfoulItem(_period[0], 1, setting),
        _teamfoulItem(_period[0], 2, setting),
        _teamfoulItem(_period[0], 3, setting),
        _teamfoulItem(_period[0], 4, setting),
        _quotaItem('3Q'),
        _teamfoulItem(_period[2], 1, setting),
        _teamfoulItem(_period[2], 2, setting),
        _teamfoulItem(_period[2], 3, setting),
        _teamfoulItem(_period[2], 4, setting),
        _filler(2),
      ],
    );
  } else {
    return Row(
      children: <Widget>[
        _filler(30),
        _quotaItem('2Q'),
        _teamfoulItem(_period[1], 1, setting),
        _teamfoulItem(_period[1], 2, setting),
        _teamfoulItem(_period[1], 3, setting),
        _teamfoulItem(_period[1], 4, setting),
        _quotaItem('4Q'),
        _teamfoulItem(_period[3], 1, setting),
        _teamfoulItem(_period[3], 2, setting),
        _teamfoulItem(_period[3], 3, setting),
        _teamfoulItem(_period[3], 4, setting),
        _filler(2),
      ],
    );
  }
}

Widget _timeoutItem(PeriodDto _data, SettingDto _setting) {
  var _mark = _data == null || _data.timeout == 0
      ? _setting.nottimeout
      : _setting.timeout;
  return Expanded(
    flex: 5,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        _mark,
        textAlign: TextAlign.center,
      ),
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget _quotaItem(String _quota) {
  return Expanded(
    flex: 5,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        _quota,
        textAlign: TextAlign.center,
      ),
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget _teamfoulItem(PeriodDto _data, int cnt, SettingDto _setting) {
  var _mark = _data == null || _data.teamfoul < cnt
      ? _setting.notteamfoul
      : _setting.teamfoul;
  return Expanded(
    flex: 5,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        _mark,
      ),
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget memberIndexSubSet() {
  return Row(
    children: <Widget>[
      _filler(2),
      Expanded(
        flex: 28,
        child: Container(
          alignment: Alignment.center,
          child: Text('氏名'),
          height: 25,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 5,
        child: Container(
          alignment: Alignment.center,
          child: Text('No'),
          height: 25,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 20,
        child: Container(
          alignment: Alignment.center,
          child: Text('出場時限'),
          height: 25,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 25,
        child: Container(
          alignment: Alignment.center,
          child: Text('ファウル'),
          height: 25,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(
              color: Colors.black,
              width: 0,
            ),
          ),
        ),
      ),
      _filler(2),
    ],
  );
}

Widget memberSheetSubSet({
  @required ResultDto data,
  @required int side,
  @required int index,
  @required SettingDto setting,
}) {
  List<BenchDto> _bench = getHomeAway(data, side, ResultUtil.bench);
  if (_bench[index].role == 0) {
    return Row(
      children: <Widget>[
        _filler(2),
        _imageItem(_bench[index], 30),
        _filler(2),
        _nameItem(_bench[index], Alignment.centerLeft),
        _numberItem(_bench[index], index),
        _periodItem(_bench[index], index, 0, setting),
        _periodItem(_bench[index], index, 1, setting),
        _periodItem(_bench[index], index, 2, setting),
        _periodItem(_bench[index], index, 3, setting),
        _foulItem(_bench[index], index, 0, setting),
        _foulItem(_bench[index], index, 1, setting),
        _foulItem(_bench[index], index, 2, setting),
        _foulItem(_bench[index], index, 3, setting),
        _foulItem(_bench[index], index, 4, setting),
        _filler(2),
      ],
    );
  } else {
    return Row(
      children: <Widget>[
        _filler(2),
        _imageItem(_bench[index], 30),
        _filler(2),
        _nameItem(_bench[index], Alignment.centerLeft),
        _numberItem(_bench[index], index),
        _foulItem(_bench[index], index, 0, setting),
        _foulItem(_bench[index], index, 1, setting),
        _foulItem(_bench[index], index, 2, setting),
        _foulItem(_bench[index], index, 3, setting),
        _foulItem(_bench[index], index, 4, setting),
        _filler(2),
      ],
    );
  }
}

Widget _numberItem(BenchDto _data, int _index) {
  var _size = _data.role == 0 ? 5 : 25;
  String _number;
  if (_data.role == 0) {
    _number = _data.number.toString();
  } else {
    _number = _data.role == 1 ? 'コーチ' : 'A.コーチ';
  }
  return Expanded(
    flex: _size,
    child: Container(
      alignment: Alignment.center,
      child: Text(_number),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget _periodItem(BenchDto _data, int _index, int _num, SettingDto _setting) {
  return Expanded(
    flex: 5,
    child: Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _splitePlayItem(_data.quota[_num], _setting),
          _spliteChangeItem(_data.quota[_num], _setting),
        ],
      ),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}

Widget _splitePlayItem(int _data, SettingDto _setting) {
  var _mark = _data == ResultUtil.stay ? '' : _setting.play;
  return Text(
    _mark,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
  );
}

Widget _spliteChangeItem(int _data, SettingDto _setting) {
  var _mark = _data == ResultUtil.change ? _setting.change : '';
  return Text(
    _mark,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
    ),
  );
}

Widget _foulItem(BenchDto _data, int _index, int _num, SettingDto _setting) {
  var _mark = _data.foul[_num] == '' ? _setting.notfoul : _data.foul[_num];
  return Expanded(
    flex: 5,
    child: Container(
      alignment: Alignment.center,
      child: Text(
        _mark,
        textAlign: TextAlign.center,
      ),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
      ),
    ),
  );
}
