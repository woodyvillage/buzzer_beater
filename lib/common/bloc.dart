import 'package:rxdart/rxdart.dart';

import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class ApplicationBloc {
  // トリガー
  final _getTriggerController = BehaviorSubject<bool>();
  Sink<bool> get trigger => _getTriggerController.sink;

  // 支払明細
  final _setTeamController = BehaviorSubject<List<TeamDto>>();
  Stream<List<TeamDto>> get teams => _setTeamController.stream;

  ApplicationBloc() {
    _getTriggerController.stream.listen((_trigger) async {
      // チーム情報
      TeamDao _dao = TeamDao();
      List<TeamDto> _dto = await _dao.select(TableUtil.cId);
      _setTeamController.sink.add(_dto);
    });
  }

  void dispose() {
    _getTriggerController.close();
    _setTeamController.close();
  }
}