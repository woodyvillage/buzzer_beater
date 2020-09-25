import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/routeset.dart';

class ApplicationFloat extends StatelessWidget {
  ApplicationFloat({Key key, this.index}) : super(key: key);
  final int index;

  dispatch(BuildContext context, int index) {
    switch (index) {
      default:
print('push floating $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Theme.of(context).primaryColorDark,
      icon: routesetFloatIcon[index],
      label: routesetFloatText[index],
      onPressed: () {
        dispatch(context, index);
      },
    );
  }
}