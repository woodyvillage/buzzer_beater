import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class RosterDao {
  static final ApplicationDatabase instance =
      ApplicationDatabase.privateConstructor();

  Future<List<RosterDto>> selectById(int _index) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.rosterTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_index]);
    List<RosterDto> _dto = _result.isNotEmpty
        ? _result.map((item) => RosterDto.parse(item)).toList()
        : [];
    return _dto;
  }

  Future<List<RosterDto>> selectMatchByTeamId(int _index, TeamDto _team) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.rosterTable,
        orderBy: "${TableUtil.cRole}, ${TableUtil.cNumber}",
        where: '${TableUtil.cMatch} = ? and ${TableUtil.cTeam} = ?',
        whereArgs: [_index, _team.id]);
    List<RosterDto> _dto = _result.isNotEmpty
        ? _result.map((item) => RosterDto.parse(item)).toList()
        : [];
    return _dto;
  }

  Future<int> insert(RosterDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.rosterTable, _dto.toMap());
  }

  Future<int> update(RosterDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.rosterTable, _dto.toMap(),
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(RosterDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.rosterTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}
