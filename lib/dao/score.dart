import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/util/table.dart';

class ScoreDao extends BaseDao {
  Future<List<ScoreDto>> selectById(int _match, int _team, int _score) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.scoreTable,
      [TableUtil.cMatch, TableUtil.cTeam, TableUtil.cScore],
      [_match, _team, _score],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  List<ScoreDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => ScoreDto.parse(item)).toList()
        : [];
  }
}
