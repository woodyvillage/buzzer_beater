import 'package:sqflite/sqflite.dart';

import 'package:buzzer_beater/common/table.dart';
import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/score.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class ScoreDao {
  static final ApplicationDatabase instance =
      ApplicationDatabase.privateConstructor();

  Future<List<ScoreDto>> selectByScoreId(
      int _index, MatchDto _match, TeamDto _team) async {
    Database _db = await instance.database;
    List<Map<String, dynamic>> _result = await _db.query(TableUtil.scoreTable,
        where:
            '${TableUtil.cScore} = ? and ${TableUtil.cMatch} = ? and ${TableUtil.cTeam} = ?',
        whereArgs: [_index, _match.id, _team.id]);
    List<ScoreDto> _dto = _result.isNotEmpty
        ? _result.map((item) => ScoreDto.parse(item)).toList()
        : [];
    return _dto;
  }

  Future<int> insert(ScoreDto _dto) async {
    Database _db = await instance.database;
    return await _db.insert(TableUtil.scoreTable, _dto.toMap());
  }

  Future<int> update(ScoreDto _dto) async {
    Database _db = await instance.database;
    return await _db.update(TableUtil.scoreTable, _dto.toMap(),
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }

  Future<int> delete(ScoreDto _dto) async {
    Database _db = await instance.database;
    return await _db.delete(TableUtil.scoreTable,
        where: '${TableUtil.cId} = ?', whereArgs: [_dto.id]);
  }
}
