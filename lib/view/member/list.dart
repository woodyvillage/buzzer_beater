import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/teammate.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/member/form.dart';

class MembersList extends StatefulWidget {
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  List<TeamMateDto> _teammateList;
  String _regist;

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _getTeamMate();
  }

  _getTeamMate() async {
    _teammateList = context.read<TeamMateNotifier>().getAllMembers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _teammateList =
        context.select((TeamMateNotifier mate) => mate.teammateList);
    if (_teammateList != null) {
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<MemberDto, TeamMateDto>(
                sectionList: _teammateList,
                headerBuilder: _buildHeader,
                addAutomaticKeepAlives: true,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  _regist =
                      _teammateList[sectionIndex].members[itemIndex].regist == 0
                          ? '不明'
                          : _teammateList[sectionIndex]
                              .members[itemIndex]
                              .regist
                              .toString();
                  return ListTile(
                    leading: Container(
                      child: imageItem(
                        data: _teammateList[sectionIndex].members[itemIndex],
                        size: 50,
                      ),
                    ),
                    title: titleItem(
                      data: _teammateList[sectionIndex].members[itemIndex],
                    ),
                    subtitle: Text(
                      _regist,
                    ),
                    trailing: roundNumberItem(
                      context: context,
                      team: _teammateList[sectionIndex].team,
                      member: _teammateList[sectionIndex].members[itemIndex],
                    ),
                    onTap: () {
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                        builder: (context) => MemberForm(
                          dto: _teammateList[sectionIndex].members[itemIndex],
                          edit: true,
                        ),
                      );
                      Navigator.push(
                        context,
                        materialPageRoute,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return SafeArea(
        child: Container(),
      );
    }
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    TeamMateDto _teammate = _teammateList[sectionIndex];
    return InkWell(
      child: Container(
        color: Theme.of(context).toggleableActiveColor,
        height: 48,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          _teammate.team.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        setState(
          () {
            _teammate.setSectionExpanded(!_teammate.isSectionExpanded());
          },
        );
      },
    );
  }
}
