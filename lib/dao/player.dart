import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/record.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/util/roster.dart';
import 'package:buzzer_beater/util/table.dart';

class PlayerDao {
  // order
  Future<List<PlayerDto>> getByRosterId(int _roster) async {
    var player = <PlayerDto>[];
    MemberDao _mdao = MemberDao();
    RegistDao _rdao = RegistDao();

    List<RegistDto> _rdto = await _rdao.selectByRosterId(_roster,
        [TableUtil.cNumber, TableUtil.cRole], [TableUtil.asc, TableUtil.desc]);

    for (RegistDto _regist in _rdto) {
      List<MemberDto> _mdto = await _mdao.selectById(_regist.member);

      var _player = PlayerDto()
        ..team = _regist.team
        ..roster = _roster
        ..member = _regist.member
        ..number = _regist.number
        ..role = _regist.role == RosterUtil.player
            ? RosterUtil.player
            : RosterUtil.coach
        ..name = _mdto[0].name
        ..age = _mdto[0].age
        ..jbaid = _mdto[0].jbaid
        ..image = _mdto[0].image;
      player.add(_player);
    }

    return player;
  }

  // scoreprogress
  Future<List<PlayerDto>> getByMemberId(int _roster, int _member) async {
    var player = <PlayerDto>[];
    MemberDao _mdao = MemberDao();
    RegistDao _rdao = RegistDao();

    List<RegistDto> _rdto = await _rdao.selectByMemberId(_roster, _member);
    List<MemberDto> _mdto = await _mdao.selectById(_rdto[0].member);

    var _player = PlayerDto()
      ..team = _rdto[0].team
      ..roster = _roster
      ..member = _rdto[0].member
      ..number = _rdto[0].number
      ..role = _mdto[0].role
      ..name = _mdto[0].name
      ..age = _mdto[0].age
      ..jbaid = _mdto[0].jbaid
      ..image = _mdto[0].image;
    player.add(_player);

    return player;
  }

  // result
  Future<List<PlayerDto>> getMatchByRosterId(int _roster, int _match) async {
    var player = <PlayerDto>[];
    MemberDao _mdao = MemberDao();
    RegistDao _rdao = RegistDao();
    RecordDao _dao = RecordDao();

    List<RegistDto> _rdto = await _rdao.selectByRosterId(
        _roster,
        [TableUtil.cSort, TableUtil.cRole, TableUtil.cNumber],
        [TableUtil.asc, TableUtil.desc, TableUtil.asc]);

    for (RegistDto _regist in _rdto) {
      List<MemberDto> _mdto = await _mdao.selectById(_regist.member);

      List<RecordDto> _dto =
          await _dao.selectByMatchId(_match, _roster, _regist.member);

      var _image = _mdto[0].image == null ? 'null' : _mdto[0].image;
      var _player = PlayerDto()
        ..team = _regist.team
        ..roster = _roster
        ..member = _regist.member
        ..number = _regist.number
        ..role = _regist.role
        ..sort = _regist.sort
        ..name = _mdto[0].name
        ..age = _mdto[0].age
        ..jbaid = _mdto[0].jbaid
        ..image = _image
        ..quota = [
          _dto[0].quota1,
          _dto[0].quota2,
          _dto[0].quota3,
          _dto[0].quota4
        ]
        ..foul = [
          _dto[0].foul1,
          _dto[0].foul2,
          _dto[0].foul3,
          _dto[0].foul4,
          _dto[0].foul5
        ];
      player.add(_player);
    }

    return player;
  }
}