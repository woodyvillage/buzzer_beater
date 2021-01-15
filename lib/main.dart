import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/view/frame.dart';

void main() {
  // 広告初期化
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<ApplicationBloc>(
          create: (_) => ApplicationBloc(),
        ),
        ChangeNotifierProvider<EnrollNotifier>(
          create: (_) => EnrollNotifier(),
        ),
        ChangeNotifierProvider<OrderNotifier>(
          create: (_) => OrderNotifier(),
        ),
        ChangeNotifierProvider<PurchaseNotifier>(
          create: (_) => PurchaseNotifier(),
        ),
      ],
      child: ApplicationFrame(),
    ),
  );
}
