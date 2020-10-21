import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/util/table.dart';

class MemberDao extends BaseDao {
  Future<List<MemberDto>> select(String _column) async {
    List<Map<String, dynamic>> _result = await selectOrder(
      TableUtil.memberTable,
      _column,
      TableUtil.asc,
    );
    return _toList(_result);
  }

  Future<List<MemberDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.memberTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<MemberDto>> selectByTeamId(
      int _value, String _column, String _direction) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.memberTable,
      [TableUtil.cTeam],
      [_value],
      [_column],
      [_direction],
    );
    return _toList(_result);
  }

  List<MemberDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => MemberDto.parse(item)).toList()
        : [];
  }
}
