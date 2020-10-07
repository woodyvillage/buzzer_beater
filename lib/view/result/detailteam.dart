import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/model/resultedit.dart';
import 'package:buzzer_beater/util/result.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/result/detailteaminfo.dart';
import 'package:buzzer_beater/view/result/detailmemberinfo.dart';

class ResultTeam extends StatelessWidget {
  ResultTeam({Key key, this.dto, this.side, this.setting}) : super(key: key);
  final ResultDto dto;
  final int side;
  final SettingDto setting;

  @override
  Widget build(BuildContext context) {
    TeamDto _team = getHomeAway(dto, side, ResultUtil.team);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: teamBoard(data: _team, context: context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
          ),
          ResultTeamInfo(dto: dto, side: side, setting: setting),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
          ),
          ResultMemberInfo(dto: dto, side: side, setting: setting),
        ],
      ),
    );
  }
}
