class TableUtil {
  static final databaseName = 'buzzer_beater._db';
  static final databaseVersion = 4;

  static final teamTable = 'team';
  static final memberTable = 'member';
  static final matchTable = 'match';
  static final officialTable = 'official';
  static final periodTable = 'period';
  static final pointTable = 'point';

  static final cId = '_id';
  static final cName = 'name';
  static final cMajorMain = 'majormain';
  static final cMajorShade = 'majorshade';
  static final cMinorMain = 'minormain';
  static final cMinorShade = 'minorshade';
  static final cTeam = 'team';
  static final cAge = 'age';
  static final cRegist = 'regist';
  static final cNumber = 'number';
  static final cImage = 'image';
  static final cPlace = 'place';
  static final cDate = 'date';
  static final cCoat = 'coat';
  static final cHometeam = 'hometeam';
  static final cAwayteam = 'awayteam';
  static final cMatch = 'match';
  static final cScore = 'score';

  static final cCrewchief = 'crewchief';
  static final cUmpire = 'umpire';
  static final cScorer = 'scorer';
  static final cAsst = 'asst';
  static final cTimer = 'timer';
  static final cHalf = 'half';

  static final ddlScripts = {
    '1': ['''
          CREATE TABLE $teamTable (
            $cId INTEGER PRIMARY KEY,
            $cName TEXT NOT NULL,
            $cMajorMain INTEGER NOT NULL,
            $cMajorShade INTEGER NOT NULL,
            $cMinorMain INTEGER NOT NULL,
            $cMinorShade INTEGER NOT NULL,
            $cImage TEXT
          );
          '''],
    '2': ['''
          CREATE TABLE $memberTable (
            $cId INTEGER PRIMARY KEY,
            $cTeam INTEGER NOT NULL,
            $cName TEXT NOT NULL,
            $cAge INTEGER NOT NULL,
            $cRegist INTEGER NOT NULL,
            $cNumber INTEGER,
            $cImage TEXT
          );
          '''],
    '3': ['''
          CREATE TABLE $matchTable (
            $cId INTEGER PRIMARY KEY,
            $cName TEXT NOT NULL,
            $cPlace TEXT,
            $cDate TEXT NOT NULL,
            $cCoat TEXT,
            $cHometeam INTEGER NOT NULL,
            $cAwayteam INTEGER NOT NULL
          );
          '''],
    '4': ['''
          CREATE TABLE $periodTable (
            $cId INTEGER PRIMARY KEY,
            $cMatch INTEGER NOT NULL,
            $cTeam INTEGER NOT NULL,
            $cNumber INTEGER NOT NULL,
            $cScore INTEGER NOT NULL
          );
          '''],
    // '4': ['''
    //       CREATE TABLE $officialTable (
    //         $cId INTEGER PRIMARY KEY,
    //         $cCrewchief TEXT,
    //         $cUmpire TEXT,
    //         $cScorer TEXT,
    //         $cAsst TEXT,
    //         $cTimer TEXT,
    //         $cHalf TEXT
    //       );
    //       '''],
  };
}