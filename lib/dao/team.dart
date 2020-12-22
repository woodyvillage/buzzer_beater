import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class TeamDao extends BaseDao {
  Future<int> countUnique(String _key, dynamic _value) async {
    return await cntBy(
        TeamDto(), [_key, TableUtil.cDelFlg], [_value, TableUtil.exist]);
  }

  Future<List<TeamDto>> select(String _column) async {
    List<Map<String, dynamic>> _result = await selectOrder(
      TableUtil.teamTable,
      _column,
      TableUtil.asc,
    );
    return _toList(_result);
  }

  Future<List<TeamDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.teamTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<TeamDto>> selectByName(String _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.teamTable,
      [TableUtil.cName, TableUtil.cDelFlg],
      [_value, TableUtil.exist],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  List<TeamDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => TeamDto.parse(item)).toList()
        : [];
  }
}
