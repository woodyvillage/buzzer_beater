import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/model/memberedit.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/util/form.dart';

class MemberForm extends StatefulWidget {
  MemberForm({Key key, this.dto, this.edit}) : super(key: key);
  final MemberDto dto;
  final bool edit;

  @override
  _MemberFormState createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = <FormDto>[];
  String _error = '';
  List<S2Choice<String>> _teamList = <S2Choice<String>>[];
  final _picker = ImagePicker();
  var _switchValue = true;
  FormDto _next;

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _form = buildMemberFormValue(widget.dto);
    _buildSelectListView();
  }

  void _buildSelectListView() async {
    _teamList = await buildSelectListValue();
    setState(() {});
  }

  Future _imagePicker() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        _form[0].image = File(image.path);
      },
    );
  }

  void levelingForm() {
    if (_form[2].controller.text == null ||
        _form[2].controller.text == 'null' ||
        _form[2].controller.text == '0') {
      _form[2].controller.text = '';
    }
    if (_form[3].controller.text == null ||
        _form[3].controller.text == 'null' ||
        _form[3].controller.text == '0') {
      _form[3].controller.text = '';
    }
    if (_form[4].controller.text == null ||
        _form[4].controller.text == 'null' ||
        _form[4].controller.text == '0') {
      _form[4].controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    levelingForm();
    if (_switchValue) {
      _next = _form[4];
    } else {
      _next = _form[1];
    }
    return Scaffold(
      appBar: AppBar(
        title: routesetFloatText[routesetMember],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            height: 40,
            padding: EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.centerLeft,
            child: Text(
              _error,
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          SmartSelect<String>.single(
            title: _form[0].value,
            value: _form[0].controller.text,
            choiceItems: _teamList,
            onChange: (state) =>
                setState(() => _form[0].controller.text = state.value),
            modalType: S2ModalType.bottomSheet,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      child: (_form[0].image != null)
                          ? Image.file(
                              _form[0].image,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'images/noimage.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    MaterialButton(
                      height: 100,
                      minWidth: 100,
                      color: Colors.white30,
                      onPressed: () => _imagePicker(),
                      child: Text('+'),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 145,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: SwitchListTile(
                      value: _switchValue,
                      title: Text(
                        '選手として登録',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                  ),
                  textFormField(_form[1], _form[2], 20, true),
                  numberFormField(_form[2], _form[3], 2, true),
                  numberFormField(_form[3], _next, 9, true),
                  numberFormField(_form[4], _form[1], 2, _switchValue),
                ],
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
          commandField(widget.edit),
        ],
      ),
    );
  }

  Widget textFormField(
      FormDto _form, FormDto _next, int _length, bool _switch) {
    return Container(
      width: MediaQuery.of(context).size.width - 145,
      margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: TextFormField(
        enabled: true,
        autofocus: true,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
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
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_next.node);
        },
      ),
    );
  }

  Widget numberFormField(
      FormDto _form, FormDto _next, int _length, bool _switch) {
    return Container(
      width: MediaQuery.of(context).size.width - 145,
      margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: TextFormField(
        enabled: _switch,
        autofocus: true,
        focusNode: _form.node,
        controller: _form.controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
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
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(_next.node);
        },
      ),
    );
  }

  Widget commandField(bool _switch) {
    if (_switch) {
      return Container(
        margin: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton.icon(
              color: Colors.green,
              textColor: Colors.white,
              icon: formIcon[formSubmit],
              label: formText[formSubmit],
              onPressed: () async {
                var _result = await confirmMemberValue(
                    _bloc, widget.dto, _form, _switchValue);
                context.read<TeamMateNotifier>().getAllMembers();
                if (_result == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() => _result < 0
                      ? _error = '全ての項目を入力してください'
                      : _error = 'すでに同じメンバーが登録されています');
                }
              },
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
            RaisedButton.icon(
              color: Colors.orange,
              textColor: Colors.white,
              icon: formIcon[formCancel],
              label: formText[formCancel],
              onPressed: () => Navigator.pop(context),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
            RaisedButton.icon(
              color: Colors.red,
              textColor: Colors.white,
              icon: formIcon[formDelete],
              label: formText[formDelete],
              onPressed: () async {
                var _result = await deleteMember(_bloc, widget.dto);
                context.read<TeamMateNotifier>().getAllMembers();
                if (_result == 0) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton.icon(
              color: Colors.green,
              textColor: Colors.white,
              icon: formIcon[formSubmit],
              label: formText[formSubmit],
              onPressed: () async {
                var _result = await confirmMemberValue(
                    _bloc, widget.dto, _form, _switchValue);
                context.read<TeamMateNotifier>().getAllMembers();
                if (_result == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() => _result < 0
                      ? _error = '全ての項目を入力してください'
                      : _error = 'すでに同じメンバーが登録されています');
                }
              },
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
            RaisedButton.icon(
              color: Colors.orange,
              textColor: Colors.white,
              icon: formIcon[formCancel],
              label: formText[formCancel],
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
