import 'package:rxdart/rxdart.dart';

import 'package:buzzer_beater/dao/result.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class ApplicationBloc {
  // チーム
  final _getTeamController = BehaviorSubject<bool>();
  Sink<bool> get trigger => _getTeamController.sink;

  // チーム
  final _setTeamController = BehaviorSubject<List<TeamDto>>();
  Stream<List<TeamDto>> get teams => _setTeamController.stream;

  // トリガー
  final _getDefiniteTriggerController = BehaviorSubject<bool>();
  Sink<bool> get definitetrigger => _getDefiniteTriggerController.sink;

  // 試合結果
  final _setDefiniteResultController = BehaviorSubject<List<ResultDto>>();
  Stream<List<ResultDto>> get definiteresults =>
      _setDefiniteResultController.stream;

  // トリガー（未完了）
  final _getProgressTriggerController = BehaviorSubject<bool>();
  Sink<bool> get progresstrigger => _getProgressTriggerController.sink;

  // 試合結果（未完了）
  final _setProgressResultController = BehaviorSubject<List<ResultDto>>();
  Stream<List<ResultDto>> get progressresults =>
      _setProgressResultController.stream;

  // 出場選手
  final _getParticipateController = BehaviorSubject<List<RegistDto>>();
  Sink<List<RegistDto>> get regist => _getParticipateController.sink;

  // 出場選手
  final _setParticipateController = BehaviorSubject<List<RegistDto>>();
  Stream<List<RegistDto>> get participate => _setParticipateController.stream;

  ApplicationBloc() {
    _getTeamController.stream.listen((_trigger) async {
      TeamDao _team = TeamDao();
      List<TeamDto> _teams = await _team.select(TableUtil.cId);
      _setTeamController.sink.add(_teams);
    });

    _getDefiniteTriggerController.stream.listen((_trigger) async {
      ResultDao _result = ResultDao();
      List<ResultDto> _results = await _result.getResult();
      _setDefiniteResultController.sink.add(_results);
    });

    _getProgressTriggerController.stream.listen((_trigger) async {
      ResultDao _situation = ResultDao();
      List<ResultDto> _situations = await _situation.getProgressResult();
      _setProgressResultController.sink.add(_situations);
    });

    _getParticipateController.stream.listen((_regist) {
      _setParticipateController.sink.add(_regist);
    });
  }

  void dispose() {
    _getTeamController.close();
    _setTeamController.close();

    _getDefiniteTriggerController.close();
    _setDefiniteResultController.close();

    _getProgressTriggerController.close();
    _setProgressResultController.close();

    _getParticipateController.close();
    _setParticipateController.close();
  }
}
