class SettingUtil {
  static final indexchar = ['①', '②', '③', '④', 'OT', 'Q', '1', '2', '3', '4'];
  static final settings = [
    [true, '', 'ランニングスコアシート', null, null, null],
    [false, String, 'フィールドゴール', '得点時にランニングスコアに上書きで表示します', 'fieldgoal', '／'],
    [false, String, 'フリースロー', '得点時にランニングスコアに上書きで表示します', 'freethrow', '●'],
    [false, String, 'オウンゴール', '得点時にランニングスコアに上書きで表示します', 'owngoal', '▲'],
    [
      false,
      String,
      'クォータ・延長・ゲーム終了',
      '各クォータ・各延長・ゲームの終了時点の最後の得点に上書きで表示します',
      'periodend',
      '〇'
    ],
    [true, '', 'タイムアウト', null, null, null],
    [false, String, 'タイムアウト', 'タイムアウトを取得した時限に上書きで表示します', 'timeout', 'Ｘ'],
    [false, String, 'タイムアウト', 'タイムアウトを取得しなかった時限に上書きで表示します', 'nottimeout', '－'],
    [true, '', 'チームファウル', null, null, null],
    [false, String, 'チームファウル', 'ファウルがあった回数に上書きで表示します', 'teamfoul', 'Ｘ'],
    [false, String, 'チームファウル', 'ファウルしなかった回数に上書きで表示します', 'notteamfoul', '－'],
    [true, '', 'ファウル', null, null, null],
    [false, String, 'ファウル', 'ファウルしなかった回数に上書きで表示します', 'foul', '－'],
    [true, '', 'チームメンバー', null, null, null],
    [false, String, '出場', '出場時限に上書きで表示します', 'play', '／'],
    [false, String, '途中出場', '交代で出場した時限に上書きで表示します', 'change', '＼'],
  ];

  static final settingCaption = 0;
  static final settingType = 1;
  static final settingTitle = 2;
  static final settingNote = 3;
  static final settingName = 4;
  static final settingDefault = 5;

  static final fieldgoal = 1;
  static final freethrow = 2;
  static final owngoal = 3;
  static final periodend = 4;
  static final timeout = 6;
  static final nottimeout = 7;
  static final teamfoul = 9;
  static final notteamfoul = 10;
  static final notfoul = 12;
  static final play = 14;
  static final change = 15;

  static final messageTeamDelete = 1;
  static final messageMemberDelete = 3;
  static final messageRosterDelete = 5;
}
