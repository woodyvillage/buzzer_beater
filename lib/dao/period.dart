import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class PeriodDao {
  static final ApplicationDatabase instance =
      ApplicationDatabase.privateConstructor();

  Future<int> sumMatchByTeamId(int _index, TeamDto _team) async {
    Database _db = await instance.database;
    return Sqflite.firstIntValue(await _db.query(TableUtil.periodTable,
        columns: ['sum(${TableUtil.cScore})'],
        where: '${TableUtil.cMatch} = ? and ${TableUtil.cTeam} = ?',
        whereArgs: [_index, _team.id]));
  }

  Future<List<PeriodDto>> selectMatchByTeamId(int _index, TeamDto _team) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.periodTable,
        orderBy: TableUtil.cPeriod,
        where: '${TableUtil.cMatch} = ? and ${TableUtil.cTeam} = ?',
        whereArgs: [_index, _team.id]);
    List<PeriodDto> _dto = _result.isNotEmpty
        ? _result.map((item) => PeriodDto.parse(item)).toList()
        : [];
    return _dto;
  }

  Future<int> insert(PeriodDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.periodTable, _dto.toMap());
  }

  Future<int> update(PeriodDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.periodTable, _dto.toMap(),
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(PeriodDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.periodTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}
