import 'package:buzzer_beater/dao/base.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/table.dart';

class RecordDao extends BaseDao {
  Future<List<RecordDto>> selectByMatch(int _match) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cMatch],
      [_match],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectByMatchRosterMember(
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

  Future<List<RecordDto>> selectByMatchTeamRosterMember(
      int _match, int _team, int _roster, int _member) async {
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cMatch, TableUtil.cTeam, TableUtil.cRoster, TableUtil.cMember],
      [_match, _team, _roster, _member],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  Future<List<RecordDto>> selectByMatchRosterQuarter(
      int _match, int _roster, int _quarter) async {
    String _cQuarter;
    switch (_quarter) {
      case 1:
        _cQuarter = TableUtil.cQuarter1;
        break;
      case 2:
        _cQuarter = TableUtil.cQuarter2;
        break;
      case 3:
        _cQuarter = TableUtil.cQuarter3;
        break;
      case 4:
        _cQuarter = TableUtil.cQuarter4;
        break;
      default:
    }
    List<Map<String, dynamic>> _result = await selectBy(
      TableUtil.recordTable,
      [TableUtil.cMatch, TableUtil.cRoster, _cQuarter],
      [_match, _roster, ApplicationUtil.play],
      [TableUtil.cId],
      [TableUtil.asc],
    );
    return _toList(_result);
  }

  void deleteByMatch(int _match) async {
    List<RecordDto> _records = await selectByMatch(_match);
    for (RecordDto _record in _records) {
      await delete(_record);
    }
  }

  List<RecordDto> _toList(List<Map<String, dynamic>> _result) {
    return _result.isNotEmpty
        ? _result.map((item) => RecordDto.parse(item)).toList()
        : [];
  }
}
