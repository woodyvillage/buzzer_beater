import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/util/table.dart';

class RosterDao extends BaseDao {
  Future<List<RosterDto>> selectById(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.rosterTable,
      [TableUtil.cId],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RosterDto>> selectByName(int _team, String _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.rosterTable,
      [TableUtil.cTeam, TableUtil.cName],
      [_team, _value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RosterDto>> selectByTeamId(
      int _value, List<String> _column, List<String> _direction) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.rosterTable,
      [TableUtil.cTeam],
      [_value],
      _column,
      _direction,
    );
    return _toList(_result);
  }

  Future<List<RosterDto>> selectByMemberId(int _value) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.rosterTable,
      [TableUtil.cMember],
      [_value],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  // Future<List<RosterDto>> selectMatchByTeamId(int _match, int _team) async {
  //   List<Map<String, dynamic>> _result = await selectBy(
  //     TableUtil.rosterTable,
  //     [TableUtil.cMatch, TableUtil.cTeam],
  //     [_match, _team],
  //     [TableUtil.cId],
  //     [TableUtil.asc],
  //   );
  //   return _toList(_result);
  // }

  List<RosterDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => RosterDto.parse(item)).toList()
        : [];
  }
}
