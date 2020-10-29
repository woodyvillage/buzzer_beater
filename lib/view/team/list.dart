import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/team/form.dart';

class TeamsList extends StatefulWidget {
  @override
  _TeamsListState createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  ApplicationBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _flush();
  }

  _flush() async {
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
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (context) => TeamForm(
                      dto: snapshot.data[index],
                      edit: true,
                    ),
                  );
                  Navigator.push(
                    context,
                    materialPageRoute,
                  );
                },
                child: teamBoardSubSet(
                  data: snapshot.data[index],
                  context: context,
                ),
              );
            },
          );
        } else {
          return ListView();
        }
      },
    );
  }
}
