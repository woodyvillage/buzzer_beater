import 'package:flutter/material.dart';

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
    for (var i = 0; i < routesetText.length; i++) {
      _bottomNavigationBarItems.add(_buildNavigationItem(i));
    }
  }

  BottomNavigationBarItem _buildNavigationItem(int index) {
    return BottomNavigationBarItem(
      icon: routesetIcon[index],
      title: routesetText[index],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (routesetFloatIcon[_selectedIndex] == null) {
      return Scaffold(
        appBar: ApplicationHeader(isView: true),
        body: routesetClass.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavigationBarItems,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    } else {
      return Scaffold(
        appBar: ApplicationHeader(isView: true),
        body: routesetClass.elementAt(_selectedIndex),
        floatingActionButton: ApplicationFloat(index: _selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavigationBarItems,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
    }
  }
}
