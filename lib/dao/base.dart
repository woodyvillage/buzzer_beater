import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class BaseDao {
  static final ApplicationDatabase instance =
      ApplicationDatabase.privateConstructor();

  Future<int> duplicateCount(
    dynamic _dto,
    List<String> _key,
    List<dynamic> _value,
  ) async {
    Database _db = await instance.database;
    if (_key.length != _value.length) {
      return null;
    }
    var _where = '';
    for (int i = 0; i < _key.length; i++) {
      if (i == 0) {
        _where = _key[i] + ' = ?';
      } else {
        _where = _where + ' and ' + _key[i] + ' = ?';
      }
    }
    return Sqflite.firstIntValue(await _db.query(
      _decision(_dto),
      columns: ['count(*)'],
      where: _where,
      whereArgs: _value,
    ));
  }

  Future<int> sumBy(
    String _table,
    List<String> _key,
    List<dynamic> _value,
    String _column,
  ) async {
    Database _db = await instance.database;
    if (_key.length != _value.length) {
      return null;
    }
    var _where = '';
    for (int i = 0; i < _key.length; i++) {
      if (i == 0) {
        _where = _key[i] + ' = ?';
      } else {
        _where = _where + ' and ' + _key[i] + ' = ?';
      }
    }
    return Sqflite.firstIntValue(await _db.query(
      _table,
      columns: ['sum(${_column})'],
      where: _where,
      whereArgs: _value,
    ));
  }

  Future<List<Map<String, dynamic>>> selectOrder(
    String _table,
    String _column,
    String _direction,
  ) async {
    Database _db = await instance.database;
    return await _db.query(
      _table,
      orderBy: _column + _direction,
    );
  }

  Future<List<Map<String, dynamic>>> selectQuery(
    String _query,
  ) async {
    Database _db = await instance.database;
    return await _db.rawQuery(
      _query,
    );
  }

  Future<List<Map<String, dynamic>>> selectBy(
    String _table,
    List<String> _key,
    List<dynamic> _value,
    List<String> _column,
    List<String> _direction,
  ) async {
    Database _db = await instance.database;
    if (_key.length != _value.length) {
      return null;
    }
    var _where = '';
    for (int i = 0; i < _key.length; i++) {
      if (i == 0) {
        _where = _key[i] + ' = ?';
      } else {
        _where = _where + ' and ' + _key[i] + ' = ?';
      }
    }
    if (_column.length != _direction.length) {
      return null;
    }
    var _order = '';
    for (int i = 0; i < _column.length; i++) {
      if (i == 0) {
        _order = _column[i] + _direction[i];
      } else {
        _order = _order + ', ' + _column[i] + _direction[i];
      }
    }
    return await _db.query(
      _table,
      where: _where,
      whereArgs: _value,
      orderBy: _order,
    );
  }

  Future<int> insert(dynamic _dto) async {
    Database _db = await instance.database;
    print('insert[${_dto.toMap()}]');
    return await _db.insert(
      _decision(_dto),
      _dto.toMap(),
    );
  }

  Future<int> update(dynamic _dto) async {
    Database _db = await instance.database;
    return await _db.update(
      _decision(_dto),
      _dto.toMap(),
      where: '${TableUtil.cId} = ?',
      whereArgs: [_dto.id],
    );
  }

  Future<int> delete(dynamic _dto) async {
    Database _db = await instance.database;
    return await _db.delete(
      _decision(_dto),
      where: '${TableUtil.cId} = ?',
      whereArgs: [_dto.id],
    );
  }

  String _decision(dynamic _dto) {
    if (_dto is TeamDto) {
      return TableUtil.teamTable;
    } else if (_dto is MemberDto) {
      return TableUtil.memberTable;
    } else if (_dto is RosterDto) {
      return TableUtil.rosterTable;
    } else if (_dto is RegistDto) {
      return TableUtil.registTable;
    } else if (_dto is MatchDto) {
      return TableUtil.matchTable;
    } else if (_dto is PeriodDto) {
      return TableUtil.periodTable;
    } else if (_dto is ScoreDto) {
      return TableUtil.scoreTable;
    } else if (_dto is RecordDto) {
      return TableUtil.recordTable;
    } else {
      return null;
    }
  }
}
