class ApplicationUtil {
  // HomeAway切り分け用
  static const teamdata = 11;
  static const totaldata = 12;
  static const perioddata = 13;
  static const playerdata = 14;
  static const progressdata = 15;
  static const quarterdata = 16;

  // ベンチ入りメンバー数
  static final benchmember = 7;

  // メンバーロール
  static final player = 0;
  static final assistant = 1;
  static final coach = 2;

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
  static const owngoal = 2;

  // Match種別
  static final typeTimeout = 0;
  static final typeMember = 1;
  static final typeFieldgoal = 2;
  static final typeFreethrow = 3;
  static final typeOwngoal = 4;
  static final typepersonal = 6;
  static final typeTschnical = 7;
  static final typeUnsportsman = 8;
  static final typeDisqualifying = 9;
  static final typeTeamfoul = 10;
  static final typePause = 11;
  static final typeFinish = 12;

  // Match配列
  static final formTitle = 0;
  static final formHint = 1;
  static final formDefault = 2;

  // Action配列
  static final functionTitle = 0;
  static final functionIcon = 1;
  static final functionColor = 2;
  static final functionEdge = 3;
}
