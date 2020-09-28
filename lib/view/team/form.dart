import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/util/form.dart';

class TeamForm extends StatefulWidget {
  TeamForm({Key key, this.dto}) : super(key: key);
  final TeamDto dto;

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = List<FormDto>();
  String _error = '';
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  final _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
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
                setState(() => _dto.border = _tempMainColor);
                setState(() => _dto.color = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker(FormDto _dto) async {
    _openDialog(
      "カラーを選んでください",
      _dto,
      MaterialColorPicker(
        selectedColor: _dto.color,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
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
      appBar: AppBar(
        title: routesetFloatText[routesetTeam],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            height: 20,
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
          Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextFormField(
              enabled: true,
              autofocus: true,
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
                  children: <Widget> [
                    Container(
                      height: 50,
                      width: 50,
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
                      height: 50,
                      minWidth: 50,
                      color: Colors.white30,
                      onPressed: () => _imagePicker(),
                      child: Text('+'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(80, 15, 15, 0),
            child: Row(
              children: [
                _form[1].icon,
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
                Expanded(
                  child: Text(_form[1].value),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: _form[1].color,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: _form[1].border,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    onPressed: () async {
                      _openColorPicker(_form[1]);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(80, 15, 15, 0),
            child: Row(
              children: [
                _form[2].icon,
                Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
                Expanded(
                  child: Text(_form[2].value),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: _form[2].color,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: _form[2].border,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                    onPressed: () async {
                      _openColorPicker(_form[2]);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
          Container(
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
                    var _result = await confirmTeamValue(_bloc, widget.dto, _form);
                    if (_result == 0) {
                      Navigator.pop(context);
                    } else {
                      setState(() => _result < 0 ? _error = 'チーム名称を入力してください' : _error = 'すでに同じチームが登録されています');
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
          ),
        ],
      ),
    );
  }
}