import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/flushbar.dart';
import 'package:buzzer_beater/model/matchedit.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/view/common/detailitems.dart';
import 'package:buzzer_beater/view/common/listitems.dart';
import 'package:buzzer_beater/view/match/panel.dart';

class ResultScore extends StatelessWidget {
  ResultScore({Key key, this.dto, this.setting}) : super(key: key);
  final ResultDto dto;
  final SettingDto setting;

  @override
  Widget build(BuildContext context) {
    ApplicationBloc _bloc = Provider.of<ApplicationBloc>(context);
    Widget _controller;
    if (dto.status != ApplicationUtil.definite) {
      _controller = commandField(context, _bloc, dto);
    } else {
      _controller = Container();
    }
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: resultPanelTeamSubSet(data: dto, score: false),
          ),
          _controller,
          Container(
            height: MediaQuery.of(context).size.height - 249,
            child: ListView.builder(
              itemCount:
                  dto.hometotal > dto.awaytotal ? dto.hometotal : dto.awaytotal,
              itemBuilder: (BuildContext context, int index) {
                return runningScoreSubSet(
                    data: dto, index: index, setting: setting);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget commandField(
      BuildContext _context, ApplicationBloc _bloc, ResultDto _dto) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          submitButton(_context, _dto),
          deleteButton(_context, _bloc, _dto),
        ],
      ),
    );
  }

  Widget submitButton(BuildContext _context, ResultDto _dto) {
    return RaisedButton.icon(
      color: Colors.green,
      textColor: Colors.white,
      icon: formIcon[formStart],
      label: formText[formStart],
      onPressed: () async {
        MaterialPageRoute matchPageRoute = MaterialPageRoute(
          builder: (_context) => MatchPanel(match: _dto.match.id),
        );
        await Navigator.push(
          _context,
          matchPageRoute,
        );
      },
    );
  }

  Widget deleteButton(
      BuildContext _context, ApplicationBloc _bloc, ResultDto _dto) {
    return Row(
      children: <Widget>[
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5)),
        RaisedButton.icon(
          color: Colors.red,
          textColor: Colors.white,
          icon: formIcon[formDelete],
          label: formText[formDelete],
          onPressed: () async {
            await deleteMatchValue(_bloc, _dto);
            Navigator.pop(_context);
            showInformation(_context, '削除しました');
            _bloc.progresstrigger.add(true);
          },
        ),
      ],
    );
  }
}
