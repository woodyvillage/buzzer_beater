import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/view/common/listitems.dart';
import 'package:buzzer_beater/view/team/form.dart';

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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TeamForm(
                      dto: snapshot.data[index]
                    )),
                  );
                },
                child: Card(
                  elevation: 8,
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: SizedBox(
                    height: 110,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          imageItem(data: snapshot.data[index]),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleItem(data: snapshot.data[index]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return ListView();
        }
      }
    );
  }
}