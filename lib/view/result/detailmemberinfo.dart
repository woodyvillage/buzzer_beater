import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/bench.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/result.dart';
import 'package:buzzer_beater/view/common/detailitems.dart';

class ResultMemberInfo extends StatelessWidget {
  ResultMemberInfo({Key key, this.dto, this.side, this.setting})
      : super(key: key);
  final ResultDto dto;
  final int side;
  final SettingDto setting;

  @override
  Widget build(BuildContext context) {
    List<BenchDto> _bench = getHomeAway(dto, side, ResultUtil.bench);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 408,
            child: ListView.builder(
              itemCount: _bench.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return memberIndexSubSet();
                }
                index -= 1;
                if (index == _bench.length) {
                  return memberIndexSubSet();
                }
                return memberSheetSubSet(
                    data: dto, side: side, index: index, setting: setting);
              },
            ),
          ),
        ],
      ),
    );
  }
}
