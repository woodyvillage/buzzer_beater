import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/help/item.dart';

class HelpPanel extends StatelessWidget {
  HelpPanel({Key key, this.questions, this.answers}) : super(key: key);
  final List<String> questions;
  final List<String> answers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('操作説明'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return HelpItem(index: index, left: questions, right: answers);
        },
      ),
    );
  }
}
