import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/util/table.dart';

class MatchDao extends BaseDao {
  Future<List<MatchDto>> selectByStatus(String _column, int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.matchTable,
      [TableUtil.cStatus],
      [_value],
      [_column],
      [TableUtil.desc],
    );
    return _result == null ? null : _toList(_result);
  }

  Future<List<MatchDto>> selectByNotStatus(String _column, int _value) async {
    List<Map<String, dynamic>> _result = await selectByNot(
      TableUtil.matchTable,
      [TableUtil.cStatus],
      [_value],
      [_column],
      [TableUtil.desc],
    );
    return _result == null ? null : _toList(_result);
  }

  Future<List<MatchDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.matchTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<MatchDto>> selectByNamePlaceTeamRoster(
    String _name,
    String _place,
    String _coat,
    int _hometeam,
    int _awayteam,
    int _homeroster,
    int _awayroster,
  ) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.matchTable,
      [
        TableUtil.cName,
        TableUtil.cPlace,
        TableUtil.cCoat,
        TableUtil.cHometeam,
        TableUtil.cAwayteam,
        TableUtil.cHomeroster,
        TableUtil.cAwayroster
      ],
      [
        _name,
        _place,
        _coat,
        _hometeam,
        _awayteam,
        _homeroster,
        _awayroster,
      ],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  void deleteByMatch(int _match) async {
    List<MatchDto> _matchs = await selectById(_match);
    for (MatchDto _match in _matchs) {
      await delete(_match);
    }
  }

  List<MatchDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => MatchDto.parse(item)).toList()
        : [];
  }
}
