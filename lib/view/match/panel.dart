import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/dto/regist.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/model/matchedit.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/view/common/panelitems.dart';
import 'package:buzzer_beater/view/help/help.dart';

class MatchPanel extends StatefulWidget {
  MatchPanel({Key key, this.match}) : super(key: key);
  final int match;

  @override
  _MatchPanelState createState() => _MatchPanelState();
}

class _MatchPanelState extends State<MatchPanel> {
  ApplicationBloc _bloc;
  ResultDto _result;
  List<RegistDto> _participate = <RegistDto>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
    for (int i = 0; i < ApplicationUtil.benchmember * 2; i++) {
      var _dto = RegistDto();
      _participate.add(_dto);
    }
    _bloc.regist.add(_participate);
  }

  @override
  void initState() {
    super.initState();
    _getMatch();
  }

  void _getMatch() async {
    _result = await getMatch(widget.match);
    _result.context = context;
    _result.bloc = _bloc;
    _participate =
        _result.quarter > 0 ? getMatchParticipate(_result) : _participate;
    _bloc.regist.add(_participate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_result != null) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(_result.match.name),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                  builder: (context) => HelpPanel(
                      questions: match_questions, answers: match_answers),
                );
                Navigator.push(
                  context,
                  materialPageRoute,
                );
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.symmetric(vertical: 1)),
            StreamBuilder(
              stream: Provider.of<ApplicationBloc>(context).participate,
              builder: (_, AsyncSnapshot snapshot) =>
                  matchPanelFunctionSubSet(_result, snapshot.data),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: StreamBuilder(
                    stream: Provider.of<ApplicationBloc>(context).participate,
                    builder: (_, AsyncSnapshot snapshot) =>
                        matchPanelMemberSubSet(
                            _result, snapshot.data, ApplicationUtil.home),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: StreamBuilder(
                    stream: Provider.of<ApplicationBloc>(context).participate,
                    builder: (_, AsyncSnapshot snapshot) =>
                        matchPanelActionSubSet(_result, snapshot.data),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: StreamBuilder(
                    stream: Provider.of<ApplicationBloc>(context).participate,
                    builder: (_, AsyncSnapshot snapshot) =>
                        matchPanelMemberSubSet(
                            _result, snapshot.data, ApplicationUtil.away),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
