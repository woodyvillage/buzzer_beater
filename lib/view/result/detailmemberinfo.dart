import 'package:flutter/material.dart';

import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/player.dart';
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
    List<PlayerDto> _player = getHomeAway(dto, side, ResultUtil.playerdata);
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 409,
            child: ListView.builder(
              itemCount: _player.length + 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return memberIndexSubSet();
                }
                index -= 1;
                if (index == _player.length) {
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
