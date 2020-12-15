import 'package:flutter/material.dart';

import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/view/match/item.dart';

class MatchHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('使い方'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return HelpItem(index: index);
        },
      ),
    );
  }
}
