import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class TeamDao {
  static final ApplicationDatabase instance =
      ApplicationDatabase.privateConstructor();

  Future<int> selectDuplicateCount(TeamDto _dto) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.teamTable,
        columns: ['count(*)'],
        where: '${TableUtil.cName} = ?',
        whereArgs: [_dto.name]));
  }

  Future<List<TeamDto>> select(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result =
        await _db.query(TableUtil.teamTable, orderBy: _column);
    List<TeamDto> _dto = _result.isNotEmpty
        ? _result.map((item) => TeamDto.parse(item)).toList()
        : [];
    return _dto;
  }

  Future<List<TeamDto>> selectById(int _index) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.teamTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_index]);
    List<TeamDto> _team = _result.isNotEmpty
        ? _result.map((item) => TeamDto.parse(item)).toList()
        : [];
    return _team;
  }

  Future<List<TeamDto>> selectByName(TeamDto _dto) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.teamTable,
        where: '${TableUtil.cName} = ?', whereArgs: [_dto.name]);
    List<TeamDto> _team = _result.isNotEmpty
        ? _result.map((item) => TeamDto.parse(item)).toList()
        : [];
    return _team;
  }

  Future<int> insert(TeamDto _dto) async {
    Database _db = await instance.database;
    print('team.insert: ${_dto.toMap()}');
    return await _db.insert(TableUtil.teamTable, _dto.toMap());
  }

  Future<int> update(TeamDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.teamTable, _dto.toMap(),
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(TeamDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.teamTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}
