import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/util/table.dart';

class RegistDao extends BaseDao {
  Future<List<RegistDto>> selectByRosterId(
      int _value, List<String> _column, List<String> _direction) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.registTable,
      [TableUtil.cRoster, TableUtil.cDelFlg],
      [_value, TableUtil.exist],
      _column,
      _direction,
    );
    return _toList(_result);
  }

  Future<List<RegistDto>> selectByMemberId(int _member) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.registTable,
      [TableUtil.cMember, TableUtil.cDelFlg],
      [_member, TableUtil.exist],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RegistDto>> selectByRosterMember(int _roster, int _member) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.registTable,
      [TableUtil.cRoster, TableUtil.cMember],
      [_roster, _member],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RegistDto>> selectByTeamRoster(int _team, int _roster) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.registTable,
      [TableUtil.cTeam, TableUtil.cRoster],
      [_team, _roster],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  void deleteByTeamRoster(int _team, int _roster) async {
    List<RegistDto> _regists = await selectByTeamRoster(_team, _roster);
    for (RegistDto _regist in _regists) {
      await delete(_regist);
    }
  }

  List<RegistDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => RegistDto.parse(item)).toList()
        : [];
  }
}
