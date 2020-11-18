import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_select/smart_select.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/flushbar.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/model/memberedit.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/model/rosteredit.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/routeset.dart';

class RosterForm extends StatefulWidget {
  RosterForm({Key key, this.dto, this.edit}) : super(key: key);
  final PlayerDto dto;
  final bool edit;

  @override
  _RosterFormState createState() => _RosterFormState();
}

class _RosterFormState extends State<RosterForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = <FormDto>[];
  List<S2Choice<String>> _teamList = <S2Choice<String>>[];
  List<S2Choice<String>> _memberList = <S2Choice<String>>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _buildFormValue();
    _buildSelectListView();
  }

  void _buildFormValue() async {
    _form = await buildRosterFormValue(widget.dto);
  }

  void _buildSelectListView() async {
    if (widget.edit) {
      _teamList = await buildTeamListValueById(widget.dto.team);
      _memberList = await buildMemberListValueByTeamId(widget.dto.team);
    } else {
      _teamList = await buildTeamListValue();
      _memberList = await buildMemberListValue();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.edit) {
      if (_form.isNotEmpty) {
        return singleRosterForm(context);
      } else {
        return Container();
      }
    } else {
      if (_form.isNotEmpty) {
        return multiRosterForm(context);
      } else {
        return Container();
      }
    }
  }

  Widget singleRosterForm(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: routesetFloatText[routesetRoster],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            selectFormField(widget.edit),
            textFormField(_form[1], 20, widget.edit),
            memberFormField(_form[2], _form[3], false),
            roleFormField(_form[2].boolvalue, _form[3].boolvalue),
            commandField(),
          ],
        ),
      ),
    );
  }

  Widget multiRosterForm(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: routesetFloatText[routesetRoster],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              height: 215,
              child: Column(
                children: <Widget>[
                  selectFormField(widget.edit),
                  textFormField(_form[1], 20, widget.edit),
                  commandField(),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 310,
              margin: const EdgeInsets.only(top: 5),
              child: ListView(
                children: <Widget>[
                  memberFormField(_form[2], _form[3], false),
                  memberFormField(_form[4], _form[5], widget.edit),
                  memberFormField(_form[6], _form[7], widget.edit),
                  memberFormField(_form[8], _form[9], widget.edit),
                  memberFormField(_form[10], _form[11], widget.edit),
                  memberFormField(_form[12], _form[13], widget.edit),
                  memberFormField(_form[14], _form[15], widget.edit),
                  memberFormField(_form[16], _form[17], widget.edit),
                  memberFormField(_form[18], _form[19], widget.edit),
                  memberFormField(_form[20], _form[21], widget.edit),
                  memberFormField(_form[22], _form[23], widget.edit),
                  memberFormField(_form[24], _form[25], widget.edit),
                  memberFormField(_form[26], _form[27], widget.edit),
                  memberFormField(_form[28], _form[29], widget.edit),
                  memberFormField(_form[30], _form[31], widget.edit),
                  memberFormField(_form[32], _form[33], widget.edit),
                  memberFormField(_form[34], _form[35], widget.edit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectFormField(bool _isEdit) {
    return SmartSelect<String>.single(
      title: _form[0].value,
      value: _form[0].controller.text,
      placeholder: '選択してください',
      choiceItems: _teamList,
      onChange: (state) async {
        _form[0].controller.text = state.value;
        _memberList =
            await buildMemberListValueByTeamId(int.parse(state.value));
        setState(() {});
      },
      modalType: S2ModalType.popupDialog,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          enabled: !_isEdit,
          isTwoLine: true,
        );
      },
    );
  }

  Widget textFormField(FormDto _form, int _length, bool _isEdit) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: TextFormField(
        enabled: !_isEdit,
        autofocus: false,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.text,
        maxLines: 1,
        maxLength: 20,
        maxLengthEnforced: false,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: _form.hint,
          labelText: _form.value,
        ),
      ),
    );
  }

  Widget memberFormField(FormDto _form, FormDto _next, bool _isEdit) {
    if (!_isEdit) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 55,
            child: memberSelect(_form),
          ),
          Expanded(
            flex: 25,
            child: memberNumber(_next, _next, 2, _next.boolvalue),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget memberSelect(FormDto _form) {
    return SmartSelect<String>.single(
      title: _form.value,
      value: _form.controller.text,
      choiceItems: _memberList,
      onChange: (state) async {
        _form.controller.text = state.value;
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

  Widget memberNumber(FormDto _form, FormDto _next, int _length, bool _switch) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: TextFormField(
        enabled: _switch,
        autofocus: false,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: _length,
        maxLengthEnforced: true,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: _form.hint,
          labelText: _form.value,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_next.node);
        },
      ),
    );
  }

  Widget roleFormField(bool _isCaptain, bool _switch) {
    return SwitchListTile(
      value: _isCaptain,
      title: Text(
        'キャプテン',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onChanged: (bool value) {
        if (_switch) {
          setState(() {
            _form[2].boolvalue = value;
          });
        }
      },
    );
  }

  Widget commandField() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          submitButton(),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
          cancelButton(),
          deleteButton(),
        ],
      ),
    );
  }

  Widget submitButton() {
    int _formIndex;
    if (widget.edit) {
      _formIndex = formUpdate;
    } else {
      _formIndex = formRegist;
    }
    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: formIcon[_formIndex],
      label: formText[_formIndex],
      onPressed: () async {
        var _result = await confirmRosterValue(_bloc, _form, widget.edit);
        if (_result == 0) {
          Navigator.pop(context);
          showInformation(context, '登録しました');
          context.read<OrderNotifier>().getOrder();
          setState(() {});
        } else {
          switch (_result) {
            case 1:
              showError(context, '同じメンバーが複数登録されています');
              break;
            case 2:
              showError(context, '同じ登録名で登録済です');
              break;
            case -1:
              showError(context, '全ての項目を入力してください');
              break;
            case -2:
              showError(context, '最低でも登録メンバーは８人必要です');
              break;
            default:
          }
        }
      },
    );
  }

  Widget cancelButton() {
    return RaisedButton.icon(
      color: Colors.orange,
      textColor: Colors.white,
      icon: formIcon[formCancel],
      label: formText[formCancel],
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget deleteButton() {
    if (widget.edit) {
      return Row(
        children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
          RaisedButton.icon(
            color: Colors.red,
            textColor: Colors.white,
            icon: formIcon[formDelete],
            label: formText[formDelete],
            onPressed: () async {
              var _result = await deleteRoster(_bloc, widget.dto);
              if (_result == 0) {
                Navigator.pop(context);
                showInformation(context, '削除しました');
                context.read<OrderNotifier>().getOrder();
              }
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
