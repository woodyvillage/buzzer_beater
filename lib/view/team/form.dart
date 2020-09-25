import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dto/form.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/teamedit.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/util/team.dart';

class TeamForm extends StatefulWidget {
  TeamForm({Key key, this.dto}) : super(key: key);
  final TeamDto dto;

  @override
  _TeamFormState createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = List<FormDto>();
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  String errorText = '';
  final _teamForm = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < teams.length; i++) {
      if (teams[i][teamDefault1] is Color) {
        var _dto = FormDto()
          ..node = FocusNode()
          ..controller = TextEditingController()
          ..icon = teams[i][teamIcon]
          ..value = teams[i][teamTitle]
          ..color = teams[i][teamDefault1]
          ..border = teams[i][teamDefault2];
        _form.add(_dto);
      } else {
        var _dto = FormDto()
          ..node = FocusNode()
          ..controller = TextEditingController()
          ..icon = teams[i][teamIcon]
          ..hint = teams[i][teamHint]
          ..value = teams[i][teamTitle];
        _form.add(_dto);
      }
    }
    if (widget.dto != null) {
      _form[0].controller.text = widget.dto.name;
      _form[1].border = Color(widget.dto.majormain);
      _form[1].color = Color(widget.dto.majorshade);
      _form[2].border = Color(widget.dto.minormain);
      _form[2].color = Color(widget.dto.minorshade);
    }
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
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
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
              errorText,
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: TextFormField(
              key: _teamForm,
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
                icon: _form[0].icon,
                hintText: _form[0].hint,
                labelText: _form[0].value,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
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
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
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
                  TeamDto _dto = TeamDto();
                  if (widget.dto != null) {
                    widget.dto.id == null ? _dto.id = null : _dto.id = widget.dto.id;
                  }
                  _form[0].controller.text == '' ? _dto.name = null : _dto.name = _form[0].controller.text;
                  _form[1].border == null ? _dto.majormain = null : _dto.majormain = _form[1].border.value;
                  _form[1].color == null ? _dto.majorshade = null : _dto.majorshade = _form[1].color.value;
                  _form[2].border == null ? _dto.minormain = null : _dto.minormain = _form[2].border.value;
                  _form[2].color == null ? _dto.minorshade = null : _dto.minorshade = _form[2].color.value;
                  var _result = await insertTeam(_bloc, _dto);
                  if (_result == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() => _result < 0 ? errorText = 'チーム名称を入力してください' : errorText = 'すでに同じチームが登録されています');
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