import 'package:flutter/material.dart';

class MessageDialog extends StatefulWidget {
  MessageDialog({Key key, this.title, this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> actions = [
      FlatButton(
        child: Text(localizations.cancelButtonLabel),
        onPressed: () => Navigator.pop<bool>(context, false),
      ),
      FlatButton(
        child: Text(localizations.okButtonLabel),
        onPressed: () => Navigator.pop<bool>(context, true),
      ),
    ];
    final AlertDialog dialog = AlertDialog(
      title: Text(widget.title),
      content: Text(widget.value),
      actions: actions,
    );

    return dialog;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
