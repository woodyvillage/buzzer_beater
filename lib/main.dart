import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/view/frame.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      Provider<ApplicationBloc>(create: (_) => ApplicationBloc()),
      ChangeNotifierProvider<TeamMateNotifier>(create: (_) => TeamMateNotifier()),
    ],
    child: ApplicationFrame(),
  ),
);