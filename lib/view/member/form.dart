import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  MemberForm({Key key, this.dto}) : super(key: key);
  final MemberDto dto;

  @override
  _MemberFormState createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  ApplicationBloc _bloc;
  List<FormDto> _form = List<FormDto>();
  String errorText = '';
  List<S2Choice<String>> _teamList = List<S2Choice<String>>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: routesetFloatText[routesetMember],
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
          SmartSelect<String>.single(
            title: _form[0].value,
            value: _form[0].controller.text,
            choiceItems: _teamList,
            onChange: (state) => setState(() => _form[0].controller.text = state.value),
            modalType: S2ModalType.bottomSheet,
            tileBuilder: (context, state) {
              return S2Tile.fromState(
                state,
                isTwoLine: true,
                // leading: const CircleAvatar(
                //   backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
                // ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: TextFormField(
              enabled: true,
              autofocus: true,
              focusNode: _form[1].node,
              controller: _form[1].controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 20,
              maxLengthEnforced: false,
              textAlignVertical: TextAlignVertical.center,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: _form[1].hint,
                labelText: _form[1].value,
              ),
              onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(_form[2].node);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: TextFormField(
              enabled: true,
              focusNode: _form[2].node,
              controller: _form[2].controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 2,
              maxLengthEnforced: true,
              textAlignVertical: TextAlignVertical.center,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: _form[2].hint,
                labelText: _form[2].value,
              ),
              inputFormatters: <TextInputFormatter> [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(_form[3].node);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: TextFormField(
              enabled: true,
              focusNode: _form[3].node,
              controller: _form[3].controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: 7,
              maxLengthEnforced: true,
              textAlignVertical: TextAlignVertical.center,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: _form[3].hint,
                labelText: _form[3].value,
              ),
              inputFormatters: <TextInputFormatter> [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              onFieldSubmitted: (v){
                FocusScope.of(context).requestFocus(_form[1].node);
              },
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
                    var _result = await confirmMemberValue(_bloc, widget.dto, _form);
                    context.read<TeamMateNotifier>().getAllMembers();
                    if (_result == 0) {
                      Navigator.pop(context);
                    } else {
                      setState(() => _result < 0 ? errorText = '全ての項目を入力してください' : errorText = 'すでに同じメンバーが登録されています');
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