class ApplicationUtil {
  // 広告関連
  static const testCode = 'ca-app-pub-3940256099942544/6300978111';
  static const liveCode = 'ca-app-pub-2248232694488898/8390769950';

  // HomeAway切り分け用
  static const teamdata = 11;
  static const totaldata = 12;
  static const perioddata = 13;
  static const playerdata = 14;
  static const progressdata = 15;
  static const quarterdata = 16;

  // 入力文字数
  static final teamNameLength = 20;
  static final memberNameLength = 7;
  static final memberAgeLength = 2;
  static final memberRegistLength = 9;
  static final memberageLength = 2;
  static final memberNumberLength = 2;
  static final matchDateLength = 20;

  // オーナー
  static final owner = 1;
  static final other = 0;

  // ベンチ入りメンバー数
  static final benchmember = 7;

  // ファール数
  static final foullimit = 5;

  // メンバーロール
  static final player = 0;
  static final captain = 1;
  static final assistant = 2;
  static final coach = 3;

  // メンバー出場状態
  static const stay = 0;
  static const play = 1;
  static const route = 3;
  static const reentry = 5;

  // チーム配置
  static final home = 0;
  static final away = 1;

  // ウェア配色
  static final homeColor = 0;
  static final awayColor = 1;
  static final mainColor = 2;
  static final edgeColor = 3;

  // タイムアウト
  static const use = 1;

  // 試合状況
  static final prepare = 0;
  static final progress = 8;
  static final definite = 9;

  // ゴールポイント
  static const fieldgoal = 2;
  static const freethrow = 1;

  // Match種別
  static final typeTimeout = 0;
  static final typeMemberchange = 1;
  static const typeFieldgoal = 2;
  static const typeFreethrow = 3;
  static const typeOwngoal = 4;
  static const typePersonal = 5;
  static const typeTechnical = 6;
  static const typeUnsportsman = 7;
  static const typeDisqualifying = 8;
  static const typeMantoman = 9;
  static const typeNotgain = 10;
  static const typeGain = 11;
  static const typeCoach = 12;
  static const typeBench = 13;
  static final typePause = 14;
  static final typeFinish = 15;

  // Match配列
  static final formTitle = 0;
  static final formHint = 1;
  static final formDefault = 2;

  // Action配列
  static final functionTitle = 0;
  static final functionIcon = 1;
  static final functionColor = 2;
  static final functionEdge = 3;
  static final functionBool = 4;
}
