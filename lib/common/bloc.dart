import 'package:rxdart/rxdart.dart';

import 'package:buzzer_beater/dao/result.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class ApplicationBloc {
  // トリガー
  final _getTriggerController = BehaviorSubject<bool>();
  Sink<bool> get trigger => _getTriggerController.sink;

  // チーム情報
  final _setTeamController = BehaviorSubject<List<TeamDto>>();
  Stream<List<TeamDto>> get teams => _setTeamController.stream;

  // 試合結果
  final _setResultController = BehaviorSubject<List<ResultDto>>();
  Stream<List<ResultDto>> get results => _setResultController.stream;

  ApplicationBloc() {
    _getTriggerController.stream.listen((_trigger) async {
      // チーム情報
      TeamDao _tdao = TeamDao();
      List<TeamDto> _tdto = await _tdao.select(TableUtil.cId);
      _setTeamController.sink.add(_tdto);

      // チーム情報
      ResultDao _rdao = ResultDao();
      List<ResultDto> _rdto = await _rdao.getAllResult();
      _setResultController.sink.add(_rdto);
    });
  }

  void dispose() {
    _getTriggerController.close();
    _setTeamController.close();
    _setResultController.close();
  }
}