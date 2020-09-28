import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/team.dart';

class ResultDto {
  MatchDto match;
  TeamDto home;
  TeamDto away;
  int homescore;
  int awayscore;
  List<PeriodDto> homeperiod;
  List<PeriodDto> awayperiod;
}