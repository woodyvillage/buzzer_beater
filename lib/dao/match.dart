import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/util/table.dart';

class MatchDao extends BaseDao {
  Future<List<MatchDto>> select(String _column) async {
    List<Map<String, dynamic>> _result = await selectOrder(
      TableUtil.matchTable,
      _column,
      TableUtil.desc,
    );
    return _toList(_result);
  }

  Future<List<MatchDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.teamTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  List<MatchDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => MatchDto.parse(item)).toList()
        : [];
  }
}
