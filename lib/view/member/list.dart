import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/common/bloc.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/teammate.dart';
import 'package:buzzer_beater/dto/member.dart';

class MembersList extends StatefulWidget {
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  ApplicationBloc _bloc;
  List<TeamMateDto> _teammateList;

  @override
  void didChangeDependencies() {
    // 起動時の最初の一回
    super.didChangeDependencies();
    _bloc = Provider.of<ApplicationBloc>(context);
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
    _teammateList = context.select((TeamMateNotifier mate) => mate.teammateList);
    if (_teammateList != null) {
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<MemberDto, TeamMateDto>(
              sectionList: _teammateList,
                headerBuilder: _buildHeader,
                addAutomaticKeepAlives : true,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      // child: (_teammateList[sectionIndex].members[itemIndex].icon != null)
                      //   ? Image.file(
                      //     File(_teammateList[sectionIndex].members[itemIndex].icon),
                      //     fit: BoxFit.cover,
                      //   )
                      //   : Image.asset(
                      //     'images/noimage.png',
                      //     fit: BoxFit.cover,
                      //   ),
                    ),
                    title: Text(_teammateList[sectionIndex].members[itemIndex].name),
                    subtitle: Text(_teammateList[sectionIndex].members[itemIndex].age.toString()),
                    trailing: CircleAvatar(
                      radius: 30,
                      child: Text(_teammateList[sectionIndex].members[itemIndex].regist.toString()),
                    ),
                    // onTap: () async {
                    //   // 登録画面
                    //   slideDialog.showSlideDialog(
                    //     context: context,
                    //     child: CatalogPalette(
                    //       id: _teammateList[sectionIndex].members[itemIndex].id,
                    //       shop: _teammateList[sectionIndex].members[itemIndex].shop,
                    //       name: _teammateList[sectionIndex].members[itemIndex].name,
                    //       note: _teammateList[sectionIndex].members[itemIndex].note,
                    //       price: _teammateList[sectionIndex].members[itemIndex].price,
                    //       icon: _teammateList[sectionIndex].members[itemIndex].icon,
                    //     ),
                    //     barrierColor: Colors.black.withOpacity(0.7),
                    //     backgroundColor: Theme.of(context).canvasColor,
                    //   );
                    // },
                    // onLongPress: () async {
                    //   await catalogPayment(context, _bloc, _teammateList[sectionIndex].members[itemIndex]);
                    // }
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
        setState(() {
          _teammate.setSectionExpanded(!_teammate.isSectionExpanded());
        });
      },
    );
  }
}