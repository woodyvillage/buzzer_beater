class TableUtil {
  static final databaseName = 'buzzer_beater._db';
  static final databaseVersion = 2;

  static final teamTable = 'team';
  static final memberTable = 'member';

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
  };
}