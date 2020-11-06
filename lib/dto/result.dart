import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/player.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';

class ResultDto {
  MatchDto match;
  TeamDto home;
  TeamDto away;
  int hometotal;
  int awaytotal;
  List<PeriodDto> homeperiod;
  List<PeriodDto> awayperiod;
  List<PlayerDto> homeplayers;
  List<PlayerDto> awayplayers;
  List<ScoreProgressDto> homeprogress;
  List<ScoreProgressDto> awayprogress;
  int quarter;
  int status;
}
