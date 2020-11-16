import 'package:flutter/material.dart';

import 'package:buzzer_beater/view/settings/body.dart';

class ApplicationHeader extends StatelessWidget with PreferredSizeWidget {
  ApplicationHeader({Key key, this.isView}) : super(key: key);
  final bool isView;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (isView) {
      return AppBar(
        centerTitle: true,
        title: Text('ミニバススコアブック'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                MaterialPageRoute settingPageRoute = MaterialPageRoute(
                  builder: (context) => SettingBody(),
                );
                Navigator.push(
                  context,
                  settingPageRoute,
                );
              },
            ),
          ),
        ],
      );
    } else {
      return AppBar(
        centerTitle: true,
        title: Text('設定画面'),
      );
    }
  }
}
