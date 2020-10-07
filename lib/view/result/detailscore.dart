import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/common/detailitems.dart';
import 'package:buzzer_beater/view/common/listitems.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';

class ResultScore extends StatelessWidget {
  ResultScore({Key key, this.dto, this.setting}) : super(key: key);
  final ResultDto dto;
  final SettingDto setting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: matchPanelTeamSubSet(data: dto),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 209,
            child: ListView.builder(
              itemCount:
                  dto.hometotal > dto.awaytotal ? dto.hometotal : dto.awaytotal,
              itemBuilder: (BuildContext context, int index) {
                return runningScoreSubSet(
                    data: dto, index: index, setting: setting);
              },
            ),
          ),
        ],
      ),
    );
  }
}
