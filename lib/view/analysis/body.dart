import 'package:flutter/material.dart';

class AnalysisList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Text('分析'),
      ),
    );
  }
}
