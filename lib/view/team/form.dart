import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/flushbar.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/util/team.dart';

class TeamForm extends StatefulWidget {
  TeamForm({Key key, this.dto, this.edit}) : super(key: key);
  final TeamDto dto;
  final bool edit;

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = <FormDto>[];
  Color _tempMainColor;
  Color _tempShadeColor;
  final _picker = ImagePicker();
  var _hasSupport = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _form = buildTeamFormValue(widget.dto);
  }

  void _openDialog(String title, FormDto _dto, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('中止'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('決定'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _dto.mainColor = _tempMainColor);
                setState(() => _dto.edgeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker(FormDto _dto, int _color) async {
    var _title = _color == TeamUtil.mainColor
        ? _dto.value + 'を選んでください'
        : _dto.value + 'のエッジ色を選んでください';
    _openDialog(
      _title,
      _dto,
      MaterialColorPicker(
        selectedColor: _dto.mainColor,
        onColorChange: (color) => setState(() => _color == TeamUtil.mainColor
            ? _tempMainColor = _tempShadeColor = color
            : _tempShadeColor = color),
      ),
    );
  }

  Future _imagePicker() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _form[0].image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: routesetFloatText[routesetTeam],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
            teamImageField(),
            formField(_form[1]),
            formField(_form[2]),
            firstMemberSupoport(),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
            commandField(),
          ],
        ),
      ),
    );
  }

  Widget teamImageField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        enabled: true,
        autofocus: false,
        focusNode: _form[0].node,
        controller: _form[0].controller,
        keyboardType: TextInputType.text,
        maxLines: 1,
        maxLength: 20,
        maxLengthEnforced: false,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: _form[0].hint,
          labelText: _form[0].value,
          icon: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: _form[0].image != null
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
      ),
    );
  }

  Widget formField(FormDto _form) {
    return Container(
      margin: const EdgeInsets.fromLTRB(80, 15, 15, 0),
      child: Row(
        children: [
          _form.icon,
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
          Expanded(
            child: Text(_form.value),
          ),
          Container(
            width: 50.0,
            height: 50.0,
            child: RaisedButton(
              color: _form.mainColor,
              shape: CircleBorder(
                side: BorderSide(
                  color: _form.edgeColor,
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
              onPressed: () {
                _openColorPicker(_form, TeamUtil.edgeColor);
                _openColorPicker(_form, TeamUtil.mainColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget firstMemberSupoport() {
    if (!widget.edit) {
      return Container(
        margin: const EdgeInsets.fromLTRB(80, 5, 0, 0),
        child: Row(
          children: <Widget>[
            Icon(Icons.supervisor_account),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 1)),
            Expanded(
              child: SwitchListTile(
                value: _hasSupport,
                title: Text(
                  'とりあえずのメンバーで初期登録を済ませる',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                onChanged: (bool value) {
                  setState(() {
                    _hasSupport = value;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
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
        var _result =
            await confirmTeamValue(_bloc, widget.dto, _form, _hasSupport);
        if (_result == 0) {
          Navigator.pop(context);
          showInformation(context, '登録しました');
        } else {
          showError(
              context, _result < 0 ? 'チーム名称を入力してください' : 'すでに同じチームが登録されています');
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
              var _result = await deleteTeam(_bloc, widget.dto);
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
