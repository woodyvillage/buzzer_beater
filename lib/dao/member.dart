import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class MemberDao {
  static final ApplicationDatabase instance = ApplicationDatabase.privateConstructor();

  Future<List<MemberDto>> select(String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.memberTable, orderBy: _column);
    List<MemberDto> _dto = _result.isNotEmpty
      ? _result.map((item) => MemberDto.parse(item)).toList()
      : [];
    return _dto;
  }

  Future<List<MemberDto>> selectByTeam(TeamDto _dto, String _column) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.memberTable, orderBy: _column + ' desc', where: '${TableUtil.cTeam} = ?', whereArgs: [_dto.id]);
    List<MemberDto> _menu = _result.isNotEmpty
      ? _result.map((item) => MemberDto.parse(item)).toList()
      : [];
    return _menu;
  }

  Future<int> selectCount(MemberDto _dto) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.memberTable, columns: ['count(*)'], where: '${TableUtil.cName} = ?', whereArgs: [_dto.name]));
  }

  Future<int> selectTotal() async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.memberTable, columns: ['count(*)']));
  }

  Future<int> insert(MemberDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.memberTable, _dto.toMap());
  }

  Future<int> update(MemberDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.memberTable, _dto.toMap(), where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(MemberDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.memberTable, where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}