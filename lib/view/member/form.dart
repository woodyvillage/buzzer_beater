import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_select/smart_select.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/flushbar.dart';
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
  List<S2Choice<String>> _teamList = <S2Choice<String>>[];
  final _picker = ImagePicker();
  FormDto _next;

  @override
  void didChangeDependencies() {
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
    _teamList = await buildTeamListValue();
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
        _form[4].controller.text == '-1' ||
        _form[4].controller.text == '0') {
      _form[4].controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    levelingForm();
    if (_form[5].boolvalue) {
      _next = _form[4];
    } else {
      _next = _form[1];
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: routesetFloatText[routesetMember],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
            selectFormField(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
                Expanded(
                  flex: 25,
                  child: memberImageField(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 72,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 70,
                            child: textFormField(_form[1], _form[2], 20),
                          ),
                          Expanded(
                            flex: 30,
                            child: numberFormField(_form[2], _form[3], 2, true),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 60,
                            child: numberFormField(_form[3], _form[4], 9, true),
                          ),
                          Expanded(
                            flex: 40,
                            child: numberFormField(
                                _form[4], _form[1], 2, _form[5].boolvalue),
                          ),
                        ],
                      ),
                      roleFormField(_form[5].boolvalue),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
            commandField(),
          ],
        ),
      ),
    );
  }

  Widget selectFormField() {
    return SmartSelect<String>.single(
      title: _form[0].value,
      value: _form[0].controller.text,
      placeholder: '選択してください',
      choiceItems: _teamList,
      onChange: (state) =>
          setState(() => _form[0].controller.text = state.value),
      modalType: S2ModalType.popupDialog,
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          isTwoLine: true,
        );
      },
    );
  }

  Widget memberImageField() {
    return Stack(
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
    );
  }

  Widget textFormField(FormDto _form, FormDto _next, int _length) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: TextFormField(
        enabled: true,
        autofocus: false,
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
      margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
      child: TextFormField(
        enabled: _switch,
        autofocus: false,
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

  Widget roleFormField(bool _isPlayer) {
    return SwitchListTile(
      value: _isPlayer,
      title: Text(
        '選手として登録',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onChanged: (bool value) {
        setState(() {
          _isPlayer = value;
        });
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
      _formIndex = formSubmit;
    }
    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: formIcon[_formIndex],
      label: formText[_formIndex],
      onPressed: () async {
        var _result = await confirmMemberValue(_bloc, widget.dto, _form);
        context.read<EnrollNotifier>().getEnroll();
        if (_result == 0) {
          Navigator.pop(context);
          showInformation(context, '登録しました');
        } else {
          showError(
              context, _result < 0 ? '全ての項目を入力してください' : 'すでに同じメンバーが登録されています');
          setState(() {});
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
              var _result = await deleteMember(_bloc, widget.dto);
              context.read<EnrollNotifier>().getEnroll();
              if (_result == 0) {
                Navigator.pop(context);
                showInformation(context, '削除しました');
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
