import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/common/flushbar.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/model/matchedit.dart';
import 'package:buzzer_beater/model/rosteredit.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/view/match/panel.dart';

class MatchForm extends StatefulWidget {
  MatchForm({Key key, this.dto, this.edit}) : super(key: key);
  final MatchDto dto;
  final bool edit;

  @override
  _MatchFormState createState() => _MatchFormState();
}

class _MatchFormState extends State<MatchForm> {
  List<FormDto> _form = <FormDto>[];
  List<S2Choice<String>> _teamList = <S2Choice<String>>[];
  List<S2Choice<String>> _homeRosterList = <S2Choice<String>>[];
  List<S2Choice<String>> _awayRosterList = <S2Choice<String>>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _form = buildMatchFormValue(widget.dto);
    _buildSelectListView();
  }

  void _buildSelectListView() async {
    _teamList = await buildTeamListValue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: routesetFloatText[routesetMatch],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          child: ListView(
            children: <Widget>[
              textFormField(_form[0], _form[1], 20),
              dateFormField(_form[1], _form[2], 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 60,
                    child: textFormField(_form[2], _form[3], 20),
                  ),
                  Expanded(
                    flex: 40,
                    child: textFormField(_form[3], _form[4], 10),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 55,
                    child: teamFormField(
                        _form[4], _form[5], _teamList, ApplicationUtil.home),
                  ),
                  Expanded(
                    flex: 45,
                    child: rosterFormField(_form[5], _homeRosterList),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 55,
                    child: teamFormField(
                        _form[6], _form[7], _teamList, ApplicationUtil.away),
                  ),
                  Expanded(
                    flex: 45,
                    child: rosterFormField(_form[7], _awayRosterList),
                  ),
                ],
              ),
              switchFormField(),
              Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
              commandField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(FormDto _form, FormDto _next, int _length) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 10),
      child: TextFormField(
        enabled: true,
        autofocus: false,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: _length,
        maxLengthEnforced: false,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: _form.hint,
          labelText: _form.value,
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_next.node);
        },
      ),
    );
  }

  Widget dateFormField(FormDto _form, FormDto _next, int _length) {
    var _dateFormat = DateFormat('yyyy年MM月dd日(E) HH:mm', 'ja_JP');
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: TextFormField(
        enabled: true,
        autofocus: false,
        showCursor: true,
        readOnly: true,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        maxLines: 1,
        maxLength: ApplicationUtil.matchDateLength,
        maxLengthEnforced: false,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: _form.hint,
          labelText: _form.value,
        ),
        onTap: () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _form.controller.text = _dateFormat.format(date);
              });
            },
            currentTime: DateTime.now(),
          );
        },
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_next.node);
        },
      ),
    );
  }

  Widget teamFormField(
      FormDto _team, FormDto _roster, List<S2Choice<String>> _list, int _side) {
    return SmartSelect<String>.single(
      title: _team.value,
      value: _team.controller.text,
      placeholder: '',
      choiceItems: _list,
      onChange: (state) async {
        if (_side == ApplicationUtil.home) {
          _homeRosterList =
              await buildRosterListValueByTeamId(int.parse(state.value));
        } else {
          _awayRosterList =
              await buildRosterListValueByTeamId(int.parse(state.value));
        }
        _team.controller.text = state.value;
        setState(() {});
      },
      modalType: S2ModalType.popupDialog,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
        );
      },
    );
  }

  Widget rosterFormField(FormDto _form, List<S2Choice<String>> _list) {
    return SmartSelect<String>.single(
      title: _form.value,
      value: _form.controller.text,
      placeholder: '',
      choiceItems: _list,
      onChange: (state) => setState(() => _form.controller.text = state.value),
      modalType: S2ModalType.popupDialog,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
        );
      },
    );
  }

  Widget switchFormField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(80, 5, 0, 0),
      child: Row(
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
          Expanded(
            child: SwitchListTile(
              value: _form[4].boolvalue,
              title: Text(
                'ホームチームのユニフォームカラーに濃色を使う',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onChanged: (bool value) {
                setState(() {
                  _form[4].boolvalue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget commandField() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          submitButton(),
        ],
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: formIcon[formStart],
      label: formText[formStart],
      onPressed: () async {
        var _match = await confirmMatchValue(_form);
        switch (_match) {
          case -1:
            showError(context, '全ての項目を入力してください');
            break;
          case -2:
            showError(context, 'すでに同じ試合が記録されています');
            break;
          default:
            MaterialPageRoute matchPageRoute = MaterialPageRoute(
              builder: (context) => MatchPanel(match: _match),
            );
            await Navigator.push(
              context,
              matchPageRoute,
            );
        }
      },
    );
  }
}
