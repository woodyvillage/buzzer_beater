import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/official.dart';
import 'package:buzzer_beater/util/table.dart';

class MatchDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<List<OfficialDto>> select(int _index) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.officialTable, where: '${TableUtil.cId} = ?', whereArgs: [_index]);
    List<OfficialDto> _dto = _result.isNotEmpty
      ? _result.map((item) => OfficialDto.parse(item)).toList()
      : [];
    return _dto;
  }

  Future<int> insert(OfficialDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.officialTable, _dto.toMap());
  }

  Future<int> update(OfficialDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.officialTable, _dto.toMap(), where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(OfficialDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.officialTable, where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}