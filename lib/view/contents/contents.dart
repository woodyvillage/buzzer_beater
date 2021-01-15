import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/util/routeset.dart';
import 'package:buzzer_beater/view/contents/button.dart';
import 'package:buzzer_beater/view/contents/header.dart';

class ApplicationContents extends StatefulWidget {
  @override
  _ApplicationContentsState createState() => _ApplicationContentsState();
}

class _ApplicationContentsState extends State<ApplicationContents> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();
    _buildNavigationItem();
    setState(() {
      context.read<PurchaseNotifier>().getPurchase();
    });
  }

  void _buildNavigationItem() {
    for (var i = 0; i < routesetText.length; i++) {
      _bottomNavigationBarItems.add(BottomNavigationBarItem(
        icon: routesetIcon[i],
        label: routesetText[i],
      ));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget float = Container();
    if (routesetFloatIcon[_selectedIndex] != null) {
      float = ApplicationFloat(
        index: _selectedIndex,
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: ApplicationHeader(isView: true),
      body: routesetClass.elementAt(
        _selectedIndex,
      ),
      floatingActionButton: float,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
