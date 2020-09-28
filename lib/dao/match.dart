import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/util/table.dart';

class MatchDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<List<MatchDto>> select(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.matchTable, orderBy: _column + ' desc');
    List<MatchDto> _dto = _result.isNotEmpty
      ? _result.map((item) => MatchDto.parse(item)).toList()
      : [];
    return _dto;
  }

  Future<int> insert(MatchDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.matchTable, _dto.toMap());
  }

  Future<int> update(MatchDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.matchTable, _dto.toMap(), where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(MatchDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.matchTable, where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}