import 'package:flutter/material.dart';

import 'package:buzzer_beater/dao/teammate.dart';
import 'package:buzzer_beater/dto/teammate.dart';

class TeamMateNotifier extends ChangeNotifier {
  List<TeamMateDto> _teammateList;
  List<TeamMateDto> get teammateList => _teammateList;

  getAllMembers() async {
    TeamMateDao _dao = TeamMateDao();
    _teammateList = await _dao.getAllMember();

    notifyListeners();
  }
}