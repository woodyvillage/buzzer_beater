import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import 'package:buzzer_beater/model/rosteredit.dart';

class SelectDialog extends StatefulWidget {
  SelectDialog({Key key, this.title, this.value}) : super(key: key);
  final String title;
  final int value;

  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  List<S2Choice<String>> _list = <S2Choice<String>>[];
  String _member = '';

  @override
  void initState() {
    super.initState();
    _buildSelectListView();
  }

  void _buildSelectListView() async {
    _list = await buildMemberListValueByRosterId(widget.value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> actions = [
      FlatButton(
        child: Text(localizations.cancelButtonLabel),
        onPressed: () => Navigator.pop(context),
      ),
      FlatButton(
        child: Text(localizations.okButtonLabel),
        onPressed: () {
          Navigator.pop<String>(context, _member);
        },
      ),
    ];
    final AlertDialog dialog = AlertDialog(
      title: Text(widget.title),
      content: SmartSelect<String>.single(
        title: '選手名',
        value: _member,
        placeholder: '選択してください',
        choiceItems: _list,
        onChange: (state) => setState(() => _member = state.value),
        modalType: S2ModalType.popupDialog,
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            isTwoLine: true,
          );
        },
      ),
      actions: actions,
    );

    return dialog;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
