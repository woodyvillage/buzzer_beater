import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/view/team/form.dart';
import 'package:buzzer_beater/view/team/listitems.dart';

class TeamsList extends StatefulWidget {
  @override
  _TeamsListState createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  ApplicationBloc _bloc;
  List<GlobalKey> _keylist = [];

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _flush();
  }

  _flush() async {
    // 起動時の最初の一回
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.trigger.add(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.teams,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data.length; i++) {
            _keylist.add(GlobalKey());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  // leading: circleAvatarItem(context: context, data: snapshot.data[index]),
                  title: titleItem(data: snapshot.data[index]),
                  // subtitle: subTitleItem(data: snapshot.data[index]),
                  // trailing: MaterialButton(
                  //   key: _keylist[index],
                  //   padding: const EdgeInsets.all(0),
                  //   minWidth: 5,
                  //   child: Icon(Icons.more_vert),
                  //   onPressed: () {
                  //     TeamDto _dto = TeamDto(
                  //       id: snapshot.data[index].id,
                  //       name: snapshot.data[index].name,
                  //       // date: snapshot.data[index].date,
                  //       // price: snapshot.data[index].price,
                  //       // mode: snapshot.data[index].mode,
                  //     );
                  //     showPopup(context, _bloc, _keylist[index], _dto);
                  //   },
                  // ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeamForm(
                        dto: snapshot.data[index]
                      )),
                    );
                  }
                ),
              );
            }
          );
        } else {
          return ListView();
        }
      }
    );
  }
}