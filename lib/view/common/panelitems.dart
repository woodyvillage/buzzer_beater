import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/flushbar.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/model/matchedit.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/view/common/listitems.dart';

Widget matchPanelFunctionSubSet(ResultDto _data, List<RegistDto> _select) {
  return Column(
    children: <Widget>[
      resultTeamListSubSet(data: _data, displayScore: true),
      Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _functionButton(_data, _select, 0),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
          _functionButton(_data, _select, 1),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
          _functionButton(_data, _select, 2),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
          _functionButton(_data, _select, 3),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
          _functionButton(_data, _select, 4),
        ],
      ),
    ],
  );
}

Widget _functionButton(ResultDto _data, List<RegistDto> _select, int _index) {
  dynamic _textcolor = (_index + 1 == _data.quarter &&
          _data.match.status == ApplicationUtil.progress)
      ? _data.quarter == 5
          ? Colors.yellow
          : Colors.red
      : functions[_index][ApplicationUtil.functionEdge];
  dynamic _buttoncolor;
  if (_index == 4 && _data.quarter == 4 && _data.hometotal != _data.awaytotal) {
    _buttoncolor = Colors.grey;
  } else {
    _buttoncolor = (_index + 1 < _data.quarter ||
            (_index + 1 == _data.quarter &&
                _data.match.status == ApplicationUtil.prepare))
        ? Colors.grey
        : functions[_index][ApplicationUtil.functionColor];
  }

  return SizedBox(
    height: 30,
    width: (MediaQuery.of(_data.context).size.width / 5) - 2,
    child: RaisedButton(
      child: Text(functions[_index][ApplicationUtil.functionTitle]),
      color: _buttoncolor,
      textColor: _textcolor,
      onPressed: () {},
      onLongPress: () async {
        int _result = await matchQuarterEdit(_data, _select, _index);
        switch (_result) {
          case -1:
            showError(_data.context, 'メンバーが足りていません');
            break;
          case -2:
            showError(_data.context, 'コーチとアシスタントコーチが１名ずつ必要です');
            break;
          case 1:
            showError(_data.context, 'メンバーが重複しているので訂正してください');
            break;
          case 2:
            showError(_data.context, 'まだ${_data.quarter}Qが終わっていません');
            break;
          case 3:
            showError(_data.context, 'まだ${_index}Qが終わっていません');
            break;
          case 4:
            showError(_data.context, 'すでに${_index + 1}Qは終了しています');
            break;
          default:
            var _text = _data.quarter == 5 ? '延長' : '${_data.quarter}Q';
            showInformation(
                _data.context,
                _data.match.status == ApplicationUtil.progress
                    ? _text + 'を開始します'
                    : _text + 'を終了します');
            _data.bloc.regist.add(_select);
        }
      },
    ),
  );
}

Widget matchPanelMemberSubSet(
  ResultDto _data,
  List<RegistDto> _select,
  int _side,
) {
  MainAxisAlignment _align;
  if (_side == ApplicationUtil.home) {
    _align = MainAxisAlignment.start;
  } else {
    _align = MainAxisAlignment.end;
  }
  if (_select == null) {
    return Container();
  } else {
    return Column(
      mainAxisAlignment: _align,
      children: <Widget>[
        _namePlate(_data, _select, _side, 0),
        _namePlate(_data, _select, _side, 1),
        _namePlate(_data, _select, _side, 2),
        _namePlate(_data, _select, _side, 3),
        _namePlate(_data, _select, _side, 4),
        _namePlate(_data, _select, _side, 5),
        _namePlate(_data, _select, _side, 6),
        Padding(padding: const EdgeInsets.symmetric(vertical: 2)),
        _actionToggleButton(_data, _select, _side, ApplicationUtil.typeTimeout),
        Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
        _actionSelectButton(
            _data, _select, _side, ApplicationUtil.typeMemberchange),
      ],
    );
  }
}

Widget _namePlate(
    ResultDto _data, List<RegistDto> _select, int _side, int _index) {
  Color _bgColor;
  Color _fgColor;
  String _name;
  dynamic _icon;

  if (_side == ApplicationUtil.home) {
    if (_data.match.homeware == ApplicationUtil.home) {
      _bgColor = Color(_data.home.homeMain);
      _fgColor = Color(_data.home.homeEdge);
    } else {
      _bgColor = Color(_data.home.awayMain);
      _fgColor = Color(_data.home.awayEdge);
    }
  } else {
    _bgColor = Color(_data.away.awayMain);
    _fgColor = Color(_data.away.awayEdge);
    _index = _index + ApplicationUtil.benchmember;
  }
  for (int i = 0; i < _select.length; i++) {
    if (i == _index && _select[_index].ball == ApplicationUtil.play) {
      Color _tmp = _bgColor;
      _bgColor = _fgColor;
      _fgColor = _tmp;
    }
  }

  List<PlayerDto> _players =
      getHomeAway(_data, _side, ApplicationUtil.playerdata);
  if (_select[_index].member == null) {
    _name = '';
    _icon = Container();
  } else {
    for (PlayerDto _player in _players) {
      if (_player.member == _select[_index].member) {
        _name = _player.name;
        _icon = _numberItem(_bgColor, _fgColor, _player.number.toString());
        break;
      }
    }
  }

  return RaisedButton.icon(
    padding: EdgeInsets.symmetric(horizontal: 5),
    color: _bgColor,
    textColor: _fgColor,
    icon: _icon,
    label: Flexible(
      child: Text(
        _name,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
    onPressed: () {
      if (_data.match.status == ApplicationUtil.progress) {
        for (int i = 0; i < _select.length; i++) {
          _select[i].ball =
              i == _index ? ApplicationUtil.play : ApplicationUtil.stay;
          _select[i].foul = ApplicationUtil.stay;
        }
        _data.bloc.regist.add(_select);
      }
    },
    onLongPress: () async {
      if (_data.match.status == ApplicationUtil.prepare) {
        _select[_index] = await matchMemberEntry(_data, _side);
        _data.bloc.regist.add(_select);
      }
    },
  );
}

Widget _numberItem(Color _bgColor, Color _fgColor, String _number) {
  if (_number == null || _number == 'null') {
    return Container();
  } else {
    return CircleAvatar(
      backgroundColor: _fgColor,
      radius: 9,
      child: CircleAvatar(
        backgroundColor: _bgColor,
        radius: 7,
        child: Text(
          _number,
          style: TextStyle(
            color: _fgColor,
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

Widget _actionToggleButton(
    ResultDto _data, List<RegistDto> _select, int _side, int _function) {
  List<PeriodDto> _period =
      getHomeAway(_data, _side, ApplicationUtil.perioddata);

  dynamic _buttoncolor;
  if (_data.quarter == 0) {
    _buttoncolor = Colors.grey;
  } else if (_data.quarter > 0 &&
      (_period[_data.quarter - 1].timeout == ApplicationUtil.use ||
          _data.match.status == ApplicationUtil.prepare)) {
    _buttoncolor = Colors.grey;
  } else {
    _buttoncolor = actions[_function][ApplicationUtil.functionColor];
  }

  return SizedBox(
    height: 30,
    child: RaisedButton(
      padding: EdgeInsets.all(3),
      child: Text(
        actions[_function][ApplicationUtil.functionTitle],
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: _buttoncolor,
      textColor: actions[_function][ApplicationUtil.functionEdge],
      onPressed: () {},
      onLongPress: () async {
        if (_data.match.status == ApplicationUtil.progress) {
          if (await incrementTimeOut(_data, _side)) {
            showInformation(_data.context, 'タイムアウトを取りました');
            _data.bloc.regist.add(_select);
          } else {
            showError(_data.context, 'すでにタイムアウトを取っています');
          }
        }
      },
    ),
  );
}

Widget _actionSelectButton(
    ResultDto _data, List<RegistDto> _select, int _side, int _function) {
  dynamic _buttoncolor = _data.match.status != ApplicationUtil.progress
      ? Colors.grey
      : actions[_function][ApplicationUtil.functionColor];
  int _start = _side == ApplicationUtil.home ? 0 : ApplicationUtil.benchmember;
  int _limit = _side == ApplicationUtil.home
      ? ApplicationUtil.benchmember
      : ApplicationUtil.benchmember * 2;

  return SizedBox(
    height: 30,
    child: RaisedButton(
      padding: EdgeInsets.all(3),
      child: Text(
        actions[_function][ApplicationUtil.functionTitle],
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: _buttoncolor,
      textColor: actions[_function][ApplicationUtil.functionEdge],
      onPressed: () {},
      onLongPress: () async {
        if (_data.match.status == ApplicationUtil.progress) {
          RegistDto _newmember = await matchMemberEntry(_data, _side);
          for (int i = _start; i < _limit; i++) {
            if (_select[i].ball == ApplicationUtil.play) {
              print('select ${_select[i].member}->${_newmember.member}');
              _select = await matchMemberChange(
                  _data, _select, _select[i].member, _newmember.id, _side);
              showInformation(_data.context, 'メンバーを交替しました');
              _data.bloc.regist.add(_select);
            }
          }
        }
      },
    ),
  );
}

Widget matchPanelActionSubSet(ResultDto _data, List<RegistDto> _select) {
  return Column(
    children: <Widget>[
      Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
          _actionButton(_data, _select, ApplicationUtil.typeFieldgoal),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionButton(_data, _select, ApplicationUtil.typeFreethrow),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionButton(_data, _select, ApplicationUtil.typeOwngoal),
          Padding(padding: const EdgeInsets.symmetric(vertical: 3)),
          _actionFoulButton(_data, _select, ApplicationUtil.typePersonal),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionFoulButton(_data, _select, ApplicationUtil.typeTechnical),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionFoulButton(_data, _select, ApplicationUtil.typeUnsportsman),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionFoulButton(_data, _select, ApplicationUtil.typeDisqualifying),
          Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
          _actionFoulButton(_data, _select, ApplicationUtil.typeMantoman),
          Padding(padding: const EdgeInsets.symmetric(vertical: 3)),
          _actionOptionButtonSubSet(_data, _select),
          Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
          _exitButton(_data, _select, ApplicationUtil.typePause),
          _exitButton(_data, _select, ApplicationUtil.typeFinish),
        ],
      ),
    ],
  );
}

Widget _actionButton(ResultDto _data, List<RegistDto> _select, int _function) {
  int _side;
  int _selectid;
  for (int i = 0; i < _select.length; i++) {
    if (_select[i].ball == ApplicationUtil.play) {
      _selectid = i;
      _side = i < ApplicationUtil.benchmember
          ? ApplicationUtil.home
          : ApplicationUtil.away;
      break;
    }
  }
  dynamic _buttoncolor = _data.match.status == ApplicationUtil.progress
      ? _selectid != null && _select[_selectid].role == ApplicationUtil.player
          ? actions[_function][ApplicationUtil.functionColor]
          : Colors.grey
      : Colors.grey;

  return SizedBox(
    height: 30,
    child: RaisedButton(
      padding: EdgeInsets.all(3),
      child: Text(
        actions[_function][ApplicationUtil.functionTitle],
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: _buttoncolor,
      textColor: actions[_function][ApplicationUtil.functionEdge],
      onPressed: () {},
      onLongPress: () async {
        if (_data.match.status == ApplicationUtil.progress) {
          _select = await matchMemberAction(
              _data, _select, _selectid, _side, _function);
          int _point;
          if (_function == ApplicationUtil.typeOwngoal) {
            _point = ApplicationUtil.fieldgoal;
            if (_side == ApplicationUtil.home) {
              _data.awaytotal = _data.awaytotal + _point;
            } else {
              _data.hometotal = _data.hometotal + _point;
            }
          } else {
            if (_function == ApplicationUtil.typeFieldgoal) {
              _point = ApplicationUtil.fieldgoal;
            } else if (_function == ApplicationUtil.typeFreethrow) {
              _point = ApplicationUtil.freethrow;
            }
            if (_side == ApplicationUtil.home) {
              _data.hometotal = _data.hometotal + _point;
            } else {
              _data.awaytotal = _data.awaytotal + _point;
            }
          }
          _data.bloc.regist.add(_select);
        }
      },
    ),
  );
}

Widget _actionFoulButton(
    ResultDto _data, List<RegistDto> _select, int _function) {
  int _side;
  int _selectid;
  if (_data.match.status == ApplicationUtil.progress) {
    for (int i = 0; i < _select.length; i++) {
      if (_select[i].ball == ApplicationUtil.play) {
        _selectid = i;
        _side = i < ApplicationUtil.benchmember
            ? ApplicationUtil.home
            : ApplicationUtil.away;
        break;
      }
    }
  }
  Color _color = _data.match.status == ApplicationUtil.progress
      ? actions[_function][ApplicationUtil.functionColor]
      : Colors.grey;
  dynamic _textcolor = _data.match.status == ApplicationUtil.progress
      ? actions[_function][ApplicationUtil.functionColor]
      : Colors.white;
  dynamic _buttoncolor = _data.match.status == ApplicationUtil.progress
      ? actions[_function][ApplicationUtil.functionEdge]
      : Colors.grey;
  if (_data.match.status == ApplicationUtil.progress) {
    for (int i = 0; i < _select.length; i++) {
      if (_select[i].foul != ApplicationUtil.stay &&
          _select[i].foul == _function) {
        _textcolor = actions[_function][ApplicationUtil.functionEdge];
        _buttoncolor = actions[_function][ApplicationUtil.functionColor];
      }
    }
  }

  return SizedBox(
    height: 30,
    child: RaisedButton(
      padding: EdgeInsets.all(3),
      child: Text(
        actions[_function][ApplicationUtil.functionTitle],
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: _buttoncolor,
      textColor: _textcolor,
      shape: Border(
        top: BorderSide(width: 2, color: _color),
        bottom: BorderSide(width: 2, color: _color),
        left: BorderSide(width: 2, color: _color),
        right: BorderSide(width: 2, color: _color),
      ),
      onPressed: () async {
        if (_data.match.status == ApplicationUtil.progress) {
          if (_selectid != null) {
            _select[_selectid].foul = _function;
            _data.bloc.regist.add(_select);
          }
        }
      },
      onLongPress: () async {
        if (_data.match.status == ApplicationUtil.progress &&
            _function != ApplicationUtil.typePersonal) {
          _select[_selectid].foul = _function;
          _select = await matchMemberAction(
              _data, _select, _selectid, _side, _function);
          _data.bloc.regist.add(_select);
        }
      },
    ),
  );
}

Widget _actionOptionButtonSubSet(ResultDto _data, List<RegistDto> _select) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _actionOptionButton(_data, _select, ApplicationUtil.typeNotgain),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
      _actionOptionButton(_data, _select, ApplicationUtil.typeGain),
    ],
  );
}

Widget _actionOptionButton(
    ResultDto _data, List<RegistDto> _select, int _function) {
  int _side;
  int _selectid;
  if (_data.match.status == ApplicationUtil.progress) {
    for (int i = 0; i < _select.length; i++) {
      if (_select[i].ball == ApplicationUtil.play) {
        _selectid = i;
        _side = i < ApplicationUtil.benchmember
            ? ApplicationUtil.home
            : ApplicationUtil.away;
        break;
      }
    }
  }
  dynamic _buttoncolor;
  dynamic _textcolor;
  String _text;
  if (_selectid != null && _data.match.status == ApplicationUtil.progress) {
    if (_select[_selectid].foul == ApplicationUtil.typePersonal &&
        _select[_selectid].role == ApplicationUtil.player) {
      _buttoncolor = actions[_function][ApplicationUtil.functionColor];
      _textcolor = actions[_function][ApplicationUtil.functionEdge];
      _text = actions[_function][ApplicationUtil.functionTitle];
    } else if (_select[_selectid].foul == ApplicationUtil.typeTechnical &&
        _select[_selectid].role != ApplicationUtil.player) {
      _buttoncolor = actions[_function][ApplicationUtil.functionColor];
      _textcolor = actions[_function][ApplicationUtil.functionEdge];
      _text = actions[_function + 2][ApplicationUtil.functionTitle];
    } else {
      _buttoncolor = Colors.grey;
      _textcolor = Colors.grey;
      _text = '';
    }
  } else {
    _buttoncolor = Colors.grey;
    _textcolor = Colors.grey;
    _text = '';
  }

  return SizedBox(
    height: 30,
    width: 70,
    child: RaisedButton(
      padding: EdgeInsets.all(3),
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: _buttoncolor,
      textColor: _textcolor,
      onPressed: () {},
      onLongPress: () async {
        if (_select[_selectid].role == ApplicationUtil.player) {
          _select = await matchMemberAction(
              _data, _select, _selectid, _side, _function);
        } else {
          _select = await matchMemberAction(
              _data, _select, _selectid, _side, _function + 2);
        }
        _data.bloc.regist.add(_select);
      },
    ),
  );
}

Widget _exitButton(ResultDto _data, List<RegistDto> _select, int _function) {
  dynamic _buttoncolor;
  if (_function == ApplicationUtil.typePause) {
    _buttoncolor = actions[_function][ApplicationUtil.functionColor];
  }
  if (_function == ApplicationUtil.typeFinish) {
    _buttoncolor =
        _data.quarter >= 4 && _data.match.status == ApplicationUtil.stay
            ? actions[_function][ApplicationUtil.functionColor]
            : Colors.grey;
  }
  return RaisedButton.icon(
    color: _buttoncolor,
    textColor: actions[_function][ApplicationUtil.functionEdge],
    icon: actions[_function][ApplicationUtil.functionIcon],
    label: Text(actions[_function][ApplicationUtil.functionTitle]),
    onPressed: () {
      _function == ApplicationUtil.typeFinish ? matchGameAction(_data) : null;
      Navigator.of(_data.context).popUntil((route) => route.isFirst);
      _data.bloc.progresstrigger.add(true);
      _function == ApplicationUtil.typeFinish
          ? showInformation(_data.context, '試合を終了します')
          : null;
      _data.bloc.regist.add(_select);
    },
  );
}
