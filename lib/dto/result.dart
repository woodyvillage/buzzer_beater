import 'package:buzzer_beater/dto/match.dart';
import 'package:buzzer_beater/dto/period.dart';
import 'package:buzzer_beater/dto/bench.dart';
import 'package:buzzer_beater/dto/scoreprogress.dart';
import 'package:buzzer_beater/dto/team.dart';

class ResultDto {
  MatchDto match;
  TeamDto home;
  TeamDto away;
  int homemain;
  int homeshade;
  int awaymain;
  int awayshade;
  int hometotal;
  int awaytotal;
  List<PeriodDto> homeperiod;
  List<PeriodDto> awayperiod;
  List<BenchDto> homebench;
  List<BenchDto> awaybench;
  List<ScoreProgressDto> homeprogress;
  List<ScoreProgressDto> awayprogress;
}
