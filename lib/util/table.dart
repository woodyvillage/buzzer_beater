class TableUtil {
  static final databaseName = 'buzzer_beater._db';
  static final databaseVersion = 8;

  static final asc = ' asc';
  static final desc = ' desc';

  static final cId = '_id';
  static final cName = 'name';
  static final cTeam = 'team';
  static final cMember = 'member';
  static final cNumber = 'number';
  static final cRoster = 'roster';

  static final teamTable = 'team';
  static final cHomeMain = 'homeMain';
  static final cHomeEdge = 'homeEdge';
  static final cAwayMain = 'awayMain';
  static final cAwayEdge = 'awayEdge';

  static final memberTable = 'member';
  static final cRole = 'role';
  static final cAge = 'age';
  static final cJbaId = '_jid';
  static final cImage = 'image';

  static final rosterTable = 'roster';

  static final registTable = 'regist';
  static final cSort = 'sort';
  static final cBall = 'ball';

  static final matchTable = 'match';
  static final cPlace = 'place';
  static final cDate = 'date';
  static final cCoat = 'coat';
  static final cStatus = 'status';
  static final cQuarter = 'quarter';
  static final cHometeam = 'hometeam';
  static final cAwayteam = 'awayteam';
  static final cHomeroster = 'homeroster';
  static final cAwayroster = 'awayroster';
  static final cHomeware = 'homeware';
  static final cAwayware = 'awayware';

  static final periodTable = 'period';
  static final cMatch = 'match';
  static final cPeriod = 'period';
  static final cScore = 'score';
  static final cTimeout = 'timeout';
  static final cTeamfoul = 'teamfoul';

  static final scoreTable = 'score';
  static final cPoint = 'point';

  static final recordTable = 'record';
  static final cQuarter1 = 'quarter1';
  static final cQuarter2 = 'quarter2';
  static final cQuarter3 = 'quarter3';
  static final cQuarter4 = 'quarter4';
  static final cFoul1 = 'foul1';
  static final cFoul2 = 'foul2';
  static final cFoul3 = 'foul3';
  static final cFoul4 = 'foul4';
  static final cFoul5 = 'foul5';

  static final ddlScripts = {
    '1': [
      '''
          CREATE TABLE $teamTable (
            $cId INTEGER PRIMARY KEY,
            $cName TEXT NOT NULL,
            $cHomeMain INTEGER NOT NULL,
            $cHomeEdge INTEGER NOT NULL,
            $cAwayMain INTEGER NOT NULL,
            $cAwayEdge INTEGER NOT NULL,
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
            $cJbaId INTEGER NOT NULL,
            $cNumber INTEGER,
            $cRole INTEGER NOT NULL,
            $cImage TEXT
          );
          '''
    ],
    '3': [
      '''
          CREATE TABLE $rosterTable (
            $cId INTEGER PRIMARY KEY,
            $cTeam INTEGER NOT NULL,
            $cName TEXT NOT NULL
          );
          '''
    ],
    '4': [
      '''
          CREATE TABLE $registTable (
            $cId INTEGER PRIMARY KEY,
            $cTeam INTEGER NOT NULL,
            $cRoster INTEGER NOT NULL,
            $cMember INTEGER NOT NULL,
            $cNumber INTEGER,
            $cRole INTEGER NOT NULL,
            $cSort INTEGER NOT NULL,
            $cBall INTEGER
          );
          '''
    ],
    '5': [
      '''
          CREATE TABLE $matchTable (
            $cId INTEGER PRIMARY KEY,
            $cDate TEXT NOT NULL,
            $cName TEXT NOT NULL,
            $cPlace TEXT,
            $cCoat TEXT,
            $cQuarter INTEGER NOT NULL,
            $cStatus INTEGER NOT NULL,
            $cHometeam INTEGER NOT NULL,
            $cAwayteam INTEGER NOT NULL,
            $cHomeroster INTEGER NOT NULL,
            $cAwayroster INTEGER NOT NULL,
            $cHomeware INTEGER NOT NULL,
            $cAwayware INTEGER NOT NULL
          );
          '''
    ],
    '6': [
      '''
          CREATE TABLE $periodTable (
            $cId INTEGER PRIMARY KEY,
            $cMatch INTEGER NOT NULL,
            $cTeam INTEGER NOT NULL,
            $cPeriod INTEGER NOT NULL,
            $cScore INTEGER NOT NULL,
            $cTimeout INTEGER,
            $cTeamfoul INTEGER,
            $cStatus INTEGER
          );
          '''
    ],
    '7': [
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
    '8': [
      '''
          CREATE TABLE $recordTable (
            $cId INTEGER PRIMARY KEY,
            $cTeam INTEGER NOT NULL,
            $cRoster INTEGER NOT NULL,
            $cMatch INTEGER NOT NULL,
            $cMember INTEGER NOT NULL,
            $cQuarter1 INTEGER,
            $cQuarter2 INTEGER,
            $cQuarter3 INTEGER,
            $cQuarter4 INTEGER,
            $cFoul1 TEXT,
            $cFoul2 TEXT,
            $cFoul3 TEXT,
            $cFoul4 TEXT,
            $cFoul5 TEXT
          );
          '''
    ],
  };
}
