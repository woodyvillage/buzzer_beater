import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/util/table.dart';

class PeriodDao extends BaseDao {
  Future<int> sumByMatchTeam(int _match, int _team) async {
    return await sumBy(
      TableUtil.periodTable,
      [TableUtil.cMatch, TableUtil.cTeam],
      [_match, _team],
      TableUtil.cScore,
    );
  }

  Future<List<PeriodDto>> selectByMatch(int _match) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.periodTable,
      [TableUtil.cMatch],
      [_match],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<PeriodDto>> selectByMatchTeam(int _match, int _team) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.periodTable,
      [TableUtil.cMatch, TableUtil.cTeam],
      [_match, _team],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  void deleteByMatch(int _match) async {
    List<PeriodDto> _periods = await selectByMatch(_match);
    for (PeriodDto _period in _periods) {
      await delete(_period);
    }
  }

  List<PeriodDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => PeriodDto.parse(item)).toList()
        : [];
  }
}
