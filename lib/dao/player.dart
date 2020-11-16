import 'package:buzzer_beater/dao/member.dart';
import 'package:buzzer_beater/dao/record.dart';
import 'package:buzzer_beater/dao/regist.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/record.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/util/application.dart';
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
        ..role = _regist.role == ApplicationUtil.player
            ? ApplicationUtil.player
            : ApplicationUtil.coach
        ..captain = _regist.captain
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

    List<RegistDto> _rdto = await _rdao.selectByRosterMember(_roster, _member);
    List<MemberDto> _mdto = await _mdao.selectById(_rdto[0].member);

    var _player = PlayerDto()
      ..team = _rdto[0].team
      ..roster = _roster
      ..member = _rdto[0].member
      ..number = _rdto[0].number
      ..role = _mdto[0].role
      ..captain = _rdto[0].captain
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

      List<RecordDto> _dto = await _dao.selectByMatchTeamRosterMember(
          _match, _regist.team, _roster, _regist.member);

      var _image = _mdto[0].image == null ? 'null' : _mdto[0].image;
      var _player = PlayerDto()
        ..team = _regist.team
        ..roster = _roster
        ..member = _regist.member
        ..number = _regist.number
        ..role = _regist.role
        ..captain = _regist.captain
        ..sort = _regist.sort
        ..name = _mdto[0].name
        ..age = _mdto[0].age
        ..jbaid = _mdto[0].jbaid
        ..image = _image
        ..quarter = [
          _dto[0].quarter1,
          _dto[0].quarter2,
          _dto[0].quarter3,
          _dto[0].quarter4
        ]
        ..foul = [
          _dto[0].foul1,
          _dto[0].foul2,
          _dto[0].foul3,
          _dto[0].foul4,
          _dto[0].foul5
        ]
        ..dead = _isDead(_dto[0]);
      player.add(_player);
    }

    return player;
  }

  // result
  Future<List<PlayerDto>> getMatchByRosterQuarterId(
      int _roster, int _match, int _quarter) async {
    var player = <PlayerDto>[];
    MemberDao _mdao = MemberDao();
    RegistDao _rdao = RegistDao();
    RecordDao _dao = RecordDao();

    List<RecordDto> _dto =
        await _dao.selectByMatchRosterQuarter(_match, _roster, _quarter);

    for (RecordDto _record in _dto) {
      List<MemberDto> _mdto = await _mdao.selectById(_record.member);

      List<RegistDto> _rdto =
          await _rdao.selectByRosterMember(_roster, _record.member);

      var _image = _mdto[0].image == null ? 'null' : _mdto[0].image;
      var _player = PlayerDto()
        ..team = _record.team
        ..roster = _roster
        ..member = _record.member
        ..number = _rdto[0].number
        ..role = _rdto[0].role
        ..captain = _rdto[0].captain
        ..sort = _rdto[0].sort
        ..name = _mdto[0].name
        ..age = _mdto[0].age
        ..jbaid = _mdto[0].jbaid
        ..image = _image
        ..quarter = [
          _dto[0].quarter1,
          _dto[0].quarter2,
          _dto[0].quarter3,
          _dto[0].quarter4
        ]
        ..foul = [
          _dto[0].foul1,
          _dto[0].foul2,
          _dto[0].foul3,
          _dto[0].foul4,
          _dto[0].foul5
        ]
        ..dead = _isDead(_dto[0]);
      player.add(_player);
    }

    return player;
  }

  bool _isDead(RecordDto _record) {
    List<int> _count = [0, 0, 0];
    _count = _countFoul(_record.foul1, _count);
    _count = _countFoul(_record.foul2, _count);
    _count = _countFoul(_record.foul3, _count);
    _count = _countFoul(_record.foul4, _count);
    _count = _countFoul(_record.foul5, _count);

    if (_count[0] >= 2) {
      return true;
    } else if (_count[1] >= 3) {
      return true;
    } else if (_count[0] == 1 && _count[1] == 2) {
      return true;
    } else if (_count[2] >= 3) {
      return true;
    } else {
      return false;
    }
  }

  List<int> _countFoul(String _foul, List<int> _count) {
    _count[0] = _foul != null &&
            (_foul.startsWith('T') ||
                _foul.startsWith('C') ||
                _foul.startsWith('U'))
        ? _count[0] + 1
        : _count[0];
    _count[1] =
        _foul != null && (_foul.startsWith('B')) ? _count[1] + 1 : _count[1];
    _count[2] =
        _foul != null && (_foul.startsWith('M')) ? _count[2] + 1 : _count[2];

    return _count;
  }
}
