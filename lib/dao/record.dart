import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/util/table.dart';

class RecordDao extends BaseDao {
  Future<List<RecordDto>> select(String _column) async {
    List<Map<String, dynamic>> _result = await selectOrder(
      TableUtil.recordTable,
      _column,
      TableUtil.asc,
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectByRosterId(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cRoster],
      [_value],
      [TableUtil.cNumber],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectByMemberId(int _roster, int _member) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cRoster, TableUtil.cMember],
      [_roster, _member],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectByMatchId(int _match, int _id) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cMatch, TableUtil.cMember],
      [_match, _id],
      [TableUtil.cNumber],
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
