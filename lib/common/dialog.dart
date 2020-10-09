import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/dialog/textdialog.dart';

// 入力ダイアログ表示
Future showSingleDialog({
  @required BuildContext context,
  @required String title,
  dynamic value,
  TransitionBuilder builder,
}) {
  Widget dialog;
  dialog = TextDialog(title: title, value: value);
  return showDialog(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
