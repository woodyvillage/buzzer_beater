import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:buzzer_beater/view/contents/contents.dart';

class ApplicationFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 日本語のフォントが正しく表示される対応
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ja', 'JP')],

      // テーマ
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),

      // コンテンツ
      debugShowCheckedModeBanner: false,
      home: ApplicationContents(),
    );
  }
}
