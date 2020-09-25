// import 'package:flutter/material.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/team.dart';

// dynamic _result;

Future insertTeam(ApplicationBloc _bloc, TeamDto _dto) async {
  TeamDao _dao = TeamDao();

  if (!_dto.isComplete()) {
    // 必須項目未入力
    return -1;
  }

  if (_dto.id == null && await _dao.selectCount(_dto) > 0) {
    // 重複あり
    return 1;
  }

  if (_dto.id == null) {
    // 新規登録
    await _dao.insert(_dto);
    _bloc.trigger.add(true);

    return 0;
  } else {
    // 更新登録
    await _dao.update(_dto);
    _bloc.trigger.add(true);

    return 0;
  }
}