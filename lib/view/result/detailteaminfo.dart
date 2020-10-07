import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/view/common/detailitems.dart';

class ResultTeamInfo extends StatelessWidget {
  ResultTeamInfo({Key key, this.dto, this.side, this.setting})
      : super(key: key);
  final ResultDto dto;
  final int side;
  final SettingDto setting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                teamHeaderSubSet(),
                teamIndexSubSet(),
                teamSheetSubSet(
                    data: dto, side: side, setting: setting, timeout: true),
                teamSheetSubSet(
                    data: dto, side: side, setting: setting, timeout: false),
              ],
              // },
            ),
          ),
        ],
      ),
    );
  }
}
