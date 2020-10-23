import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/result.dart';
import 'package:buzzer_beater/util/team.dart';

Widget _filler(int _flex) {
  return Expanded(
    flex: _flex,
    child: SizedBox(),
  );
}

Widget matchPanelTeamSubSet({
  @required ResultDto data,
}) {
  var _hometeam = getHomeAway(data, ResultUtil.home, ResultUtil.teamdata);
  var _awayteam = getHomeAway(data, ResultUtil.away, ResultUtil.teamdata);
  return Row(
    children: <Widget>[
      _filler(2),
      _teamColorItem(_hometeam, data.match.homeware),
      _filler(2),
      _teamNameItem(_hometeam, Alignment.centerLeft),
      _teamNameItem(_awayteam, Alignment.centerRight),
      _filler(2),
      _teamColorItem(_awayteam, data.match.awayware),
      _filler(2),
    ],
  );
}

Widget _teamColorItem(TeamDto _team, int _ware) {
  Color _mainColor;
  Color _edgeColor;
  if (_ware == TeamUtil.homeColor) {
    _mainColor = Color(_team.awayMain);
    _edgeColor = Color(_team.awayEdge);
  } else {
    _mainColor = Color(_team.homeMain);
    _edgeColor = Color(_team.homeEdge);
  }
  return Expanded(
    flex: 2,
    child: SizedBox(
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _edgeColor),
          color: _mainColor,
        ),
      ),
    ),
  );
}

Widget _teamNameItem(TeamDto _team, Alignment _align) {
  return Expanded(
    flex: 45,
    child: Container(
      alignment: _align,
      child: Text(
        _team.name,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget matchPanelScoreSubSet({
  @required ResultDto data,
}) {
  return Row(
    children: <Widget>[
      _teamTotalScoreItem(data.hometotal),
      Expanded(
        flex: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _teamPeriodItem(data, 0),
            _teamPeriodItem(data, 1),
            _teamPeriodItem(data, 2),
            _teamPeriodItem(data, 3),
            _teamPeriodItem(data, 4),
          ],
        ),
      ),
      _teamTotalScoreItem(data.awaytotal),
    ],
  );
}

Widget _teamTotalScoreItem(dynamic _total) {
  return Expanded(
    flex: 35,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          _total.toString(),
          style: TextStyle(fontSize: 45),
        ),
      ],
    ),
  );
}

Widget _teamPeriodItem(ResultDto _data, int _index) {
  String _text;
  if (_index == 4) {
    _text = '(延長)';
  } else {
    _text = '　－　';
  }

  var _homeperiod = getHomeAway(_data, ResultUtil.home, ResultUtil.perioddata);
  var _awayperiod = getHomeAway(_data, ResultUtil.away, ResultUtil.perioddata);
  if (_homeperiod.length <= _index || _awayperiod.length <= _index) {
    return Text(
      _text,
      style: TextStyle(fontSize: 16),
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _teamPeriodScoreItem(_homeperiod[_index].score, 20),
        _teamPeriodScoreItem(_text, 60),
        _teamPeriodScoreItem(_awayperiod[_index].score, 20),
      ],
    );
  }
}

Widget _teamPeriodScoreItem(dynamic _text, double _size) {
  return Container(
    alignment: Alignment.center,
    width: _size,
    child: Text(
      _text.toString(),
      style: TextStyle(fontSize: 16),
    ),
  );
}
