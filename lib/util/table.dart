class TableUtil {
  static final databaseName = 'buzzer_beater._db';
  static final databaseVersion = 6;

  static final teamTable = 'team';
  static final memberTable = 'member';
  static final matchTable = 'match';
  static final periodTable = 'period';
  static final scoreTable = 'score';
  static final rosterTable = 'roster';

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
  static final cHomeMain = 'homemain';
  static final cHomeShade = 'homeshade';
  static final cAwayMain = 'awaymain';
  static final cAwayShade = 'awayshade';
  static final cMatch = 'match';
  static final cScore = 'score';
  static final cPeriod = 'period';
  static final cMember = 'member';
  static final cPoint = 'point';
  static final cRole = 'role';
  static final cQuota1 = 'quota1';
  static final cQuota2 = 'quota2';
  static final cQuota3 = 'quota3';
  static final cQuota4 = 'quota4';
  static final cTimeout = 'timeout';
  static final cTeamfoul = 'teamfoul';
  static final cFoul1 = 'foul1';
  static final cFoul2 = 'foul2';
  static final cFoul3 = 'foul3';
  static final cFoul4 = 'foul4';
  static final cFoul5 = 'foul5';

  static final cCrewchief = 'crewchief';
  static final cUmpire = 'umpire';
  static final cScorer = 'scorer';
  static final cAsst = 'asst';
  static final cTimer = 'timer';
  static final cHalf = 'half';

  static final ddlScripts = {
    '1': [
      '''
          CREATE TABLE $teamTable (
            $cId INTEGER PRIMARY KEY,
            $cName TEXT NOT NULL,
            $cMajorMain INTEGER NOT NULL,
            $cMajorShade INTEGER NOT NULL,
            $cMinorMain INTEGER NOT NULL,
            $cMinorShade INTEGER NOT NULL,
            $cImage TEXT
          );
          '''
    ],
    '2': [
      '''
          CREATE TABLE $memberTable (
            $cId INTEGER PRIMARY KEY,
            $cTeam INTEGER NOT NULL,
            $cName TEXT NOT NULL,
            $cAge INTEGER NOT NULL,
            $cRegist INTEGER NOT NULL,
            $cNumber INTEGER,
            $cImage TEXT
          );
          '''
    ],
    '3': [
      '''
          CREATE TABLE $matchTable (
            $cId INTEGER PRIMARY KEY,
            $cName TEXT NOT NULL,
            $cPlace TEXT,
            $cDate TEXT NOT NULL,
            $cCoat TEXT,
            $cHometeam INTEGER NOT NULL,
            $cAwayteam INTEGER NOT NULL,
            $cHomeMain INTEGER NOT NULL,
            $cHomeShade INTEGER NOT NULL,
            $cAwayMain INTEGER NOT NULL,
            $cAwayShade INTEGER NOT NULL
          );
          '''
    ],
    '4': [
      '''
          CREATE TABLE $periodTable (
            $cId INTEGER PRIMARY KEY,
            $cMatch INTEGER NOT NULL,
            $cTeam INTEGER NOT NULL,
            $cPeriod INTEGER NOT NULL,
            $cScore INTEGER NOT NULL,
            $cTimeout INTEGER NOT NULL,
            $cTeamfoul INTEGER NOT NULL
          );
          '''
    ],
    '5': [
      '''
          CREATE TABLE $scoreTable (
            $cId INTEGER PRIMARY KEY,
            $cMatch INTEGER NOT NULL,
            $cTeam INTEGER NOT NULL,
            $cMember INTEGER NOT NULL,
            $cPeriod INTEGER NOT NULL,
            $cPoint INTEGER NOT NULL,
            $cScore INTEGER NOT NULL
          );
          '''
    ],
    '6': [
      '''
          CREATE TABLE $rosterTable (
            $cId INTEGER PRIMARY KEY,
            $cMatch INTEGER NOT NULL,
            $cTeam INTEGER NOT NULL,
            $cMember INTEGER NOT NULL,
            $cNumber INTEGER NOT NULL,
            $cRole INTEGER NOT NULL,
            $cQuota1 INTEGER NOT NULL,
            $cQuota2 INTEGER NOT NULL,
            $cQuota3 INTEGER NOT NULL,
            $cQuota4 INTEGER NOT NULL,
            $cFoul1 TEXT,
            $cFoul2 TEXT,
            $cFoul3 TEXT,
            $cFoul4 TEXT,
            $cFoul5 TEXT
          );
          '''
    ],
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
