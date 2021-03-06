import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/result/list.dart';

class ResultBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ResultsList(),
      ),
    );
  }
}
