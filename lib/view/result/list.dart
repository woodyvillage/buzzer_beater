import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/common/listitems.dart';
import 'package:buzzer_beater/view/result/detail.dart';

class ResultsList extends StatefulWidget {
  @override
  _ResultsListState createState() => _ResultsListState();
}

class _ResultsListState extends State<ResultsList> {
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
      stream: _bloc.results,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (context) =>
                        ResultDetail(dto: snapshot.data[index]),
                  );
                  Navigator.push(
                    context,
                    materialPageRoute,
                  );
                },
                child: Card(
                  elevation: 8,
                  color: Theme.of(context).cardColor,
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: SizedBox(
                    height: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        titleItem(data: snapshot.data[index]),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 30,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        resultPanelTeamSubSet(data: snapshot.data[index]),
                        resultPanelScoreSubSet(data: snapshot.data[index]),
                      ],
                    ),
                  ),
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
