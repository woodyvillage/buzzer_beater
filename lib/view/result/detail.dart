import 'package:flutter/material.dart';

import 'package:buzzer_beater/dao/setting.dart';
import 'package:buzzer_beater/dto/result.dart';
import 'package:buzzer_beater/dto/setting.dart';
import 'package:buzzer_beater/util/application.dart';
import 'package:buzzer_beater/util/form.dart';
import 'package:buzzer_beater/util/setting.dart';
import 'package:buzzer_beater/view/result/detailscore.dart';
import 'package:buzzer_beater/view/result/detailteam.dart';

class ResultDetail extends StatefulWidget {
  ResultDetail({Key key, this.dto}) : super(key: key);
  final ResultDto dto;

  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail>
    with TickerProviderStateMixin {
  PageController _pageController;
  int _currentIndex = 1;
  SettingDto _sdto;

  @override
  void initState() {
    super.initState();
    initPreferences();
    _pageController = PageController(
      initialPage: _currentIndex,
    );
  }

  initPreferences() async {
    SettingDao _sdao = SettingDao();
    _sdto = await _sdao.getAllPrefereces(SettingUtil.settings);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dto.match.name),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ResultTeam(
                dto: widget.dto, side: ApplicationUtil.home, setting: _sdto),
            ResultScore(dto: widget.dto, setting: _sdto),
            ResultTeam(
                dto: widget.dto, side: ApplicationUtil.away, setting: _sdto),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) {
          setState(() => _currentIndex = value);
          _pageController.jumpToPage(value);
        },
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: resultDetailIcon[0],
            title: Text(widget.dto.home.name),
          ),
          BottomNavigationBarItem(
            icon: resultDetailIcon[1],
            title: resultDetailText,
          ),
          BottomNavigationBarItem(
            icon: resultDetailIcon[2],
            title: Text(widget.dto.away.name),
          ),
        ],
      ),
    );
  }
}
