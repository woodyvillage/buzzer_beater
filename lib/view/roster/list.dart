import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/order.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/roster/form.dart';

class RosterList extends StatefulWidget {
  @override
  _RosterListState createState() => _RosterListState();
}

class _RosterListState extends State<RosterList> {
  List<OrderDto> _orderList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _getOrder();
  }

  _getOrder() async {
    setState(() {
      context.read<OrderNotifier>().getOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    _orderList = context.select((OrderNotifier order) => order.orderList);
    if (_orderList != null) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverExpandableList(
            builder: SliverExpandableChildDelegate<PlayerDto, OrderDto>(
              sectionList: _orderList,
              headerBuilder: _buildHeader,
              addAutomaticKeepAlives: true,
              itemBuilder: (context, sectionIndex, itemIndex, index) {
                return ListTile(
                  leading: Container(
                    child: imageItem(
                      data: _orderList[sectionIndex].players[itemIndex],
                      size: 50,
                    ),
                  ),
                  title: titleItem(
                    data: _orderList[sectionIndex].players[itemIndex],
                  ),
                  subtitle: Text(
                      _orderList[sectionIndex].players[itemIndex].jbaid == 0
                          ? '不明'
                          : _orderList[sectionIndex]
                              .players[itemIndex]
                              .jbaid
                              .toString()),
                  trailing: roundNumberItem(
                    context: context,
                    team: _orderList[sectionIndex].team,
                    member: _orderList[sectionIndex].players[itemIndex],
                  ),
                  onTap: () {
                    MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (context) => RosterForm(
                        dto: _orderList[sectionIndex].players[itemIndex],
                        edit: true,
                      ),
                    );
                    Navigator.push(
                      context,
                      materialPageRoute,
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    OrderDto _order = _orderList[sectionIndex];
    IconData _direction;
    if (_order.isSectionExpanded()) {
      _direction = Icons.keyboard_arrow_up;
    } else {
      _direction = Icons.keyboard_arrow_down;
    }
    return InkWell(
      child: Container(
        color: Theme.of(context).toggleableActiveColor,
        height: 48,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _order.team.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    _order.roster.name +
                        '（' +
                        _order.players.length.toString() +
                        '名）',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: Icon(
                _direction,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(
          () {
            _order.setSectionExpanded(!_order.isSectionExpanded());
          },
        );
      },
    );
  }
}
