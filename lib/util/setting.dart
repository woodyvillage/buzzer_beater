class SettingUtil {
  static final indexchar = ['①', '②', '③', '④', 'OT', 'Q', '1', '2', '3', '4'];
  static final settings = [
    ['CAP', 'ランニングスコアシート', null, null, null],
    ['INP', 'フィールドゴール', 'fieldgoal', '／'],
    ['INP', 'フリースロー', 'freethrow', '●'],
    ['INP', 'オウンゴール', 'owngoal', '▲'],
    ['INP', '各クォータ・各延長・ゲームの終了時点の最後の得点', 'periodend', '〇'],
    ['CAP', 'タイムアウト', null, null, null],
    ['INP', 'タイムアウトを取得した時限', 'timeout', 'Ｘ'],
    ['INP', 'タイムアウトを取得しなかった時限', 'nottimeout', '－'],
    ['CAP', 'チームファウル', null, null, null],
    ['INP', 'ファウルがあった', 'teamfoul', 'Ｘ'],
    ['INP', 'ファウルしなかった', 'notteamfoul', '－'],
    ['CAP', 'ファウル', null, null, null],
    ['INP', 'ファウルしなかった', 'foul', '－'],
    ['CAP', 'チームメンバー', null, null, null],
    ['INP', '出場', 'play', '／'],
    ['INP', '交代出場', 'change', '＼'],
    ['CAP', '初期化', null, null, null],
    ['BTN', '設定値を初期状態に戻す', '初期化', '設定内容を初期状態に戻しますか？'],
    ['CAP', '有料オプション', null, null, null],
    ['DLG', '広告を非表示にする', '購入', '広告を非表示にする有料オプションを購入しますか？'],
    ['CAP', 'アプリ情報', null, null],
    ['APL', 'アプリ名称', null, null],
    ['VER', 'ビルドバージョン', null, null],
  ];

  static final settingType = 0;
  static final settingTitle = 1;
  static final settingName = 2;
  static final settingDefault = 3;

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

  static final initialize = 17;
  static final charges = 19;

  static final messageTeamDelete = 0;
  static final messageMemberDelete = 1;
  static final messageRosterDelete = 2;
}
