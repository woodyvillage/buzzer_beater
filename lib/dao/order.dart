import 'package:buzzer_beater/dao/player.dart';
import 'package:buzzer_beater/dao/roster.dart';
import 'package:buzzer_beater/dao/team.dart';
import 'package:buzzer_beater/dto/order.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/roster.dart';
import 'package:buzzer_beater/dto/team.dart';
import 'package:buzzer_beater/util/table.dart';

class OrderDao {
  Future<List<OrderDto>> getOrder() async {
    var order = <OrderDto>[];
    TeamDao _tdao = TeamDao();
    RosterDao _rdao = RosterDao();
    PlayerDao _pdao = PlayerDao();

    List<TeamDto> _tdto = await _tdao.select(TableUtil.cName);
    for (TeamDto _team in _tdto) {
      List<RosterDto> _rdto = await _rdao
          .selectByTeamId(_team.id, [TableUtil.cName], [TableUtil.asc]);
      for (RosterDto _roster in _rdto) {
        List<PlayerDto> _pdto = await _pdao.getByRosterId(_roster.id);

        var _order = OrderDto()
          ..expanded = false
          ..team = _team
          ..roster = _roster
          ..players = _pdto;
        order.add(_order);
      }
    }

    return order;
  }
}
