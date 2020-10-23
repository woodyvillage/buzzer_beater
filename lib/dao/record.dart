import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/util/table.dart';

class RecordDao extends BaseDao {
  Future<List<RecordDto>> selectByMatchId(
      int _match, int _roster, int _member) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cMatch, TableUtil.cRoster, TableUtil.cMember],
      [_match, _roster, _member],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  List<RecordDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => RecordDto.parse(item)).toList()
        : [];
  }
}
