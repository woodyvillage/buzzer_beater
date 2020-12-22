import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import 'package:buzzer_beater/common/advertisement.dart';
import 'package:buzzer_beater/common/notifier.dart';
import 'package:buzzer_beater/dto/enroll.dart';
import 'package:buzzer_beater/dto/member.dart';
import 'package:buzzer_beater/view/common/boarditems.dart';
import 'package:buzzer_beater/view/member/form.dart';

class MembersList extends StatefulWidget {
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  List<EnrollDto> _enrollList;
  Widget _ad;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<EnrollNotifier>().getEnroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    _enrollList = context.select((EnrollNotifier enroll) => enroll.enrollList);
    if (_enrollList != null) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverExpandableList(
            builder: SliverExpandableChildDelegate<MemberDto, EnrollDto>(
              sectionList: _enrollList,
              headerBuilder: _buildHeader,
              addAutomaticKeepAlives: true,
              itemBuilder: (context, sectionIndex, itemIndex, index) {
                if (index % 5 == 0) {
                  _ad = AdmobBanner(
                    adUnitId: ApplicationAdvertisement().getBannerAdUnitId(),
                    adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                      width: MediaQuery.of(context).size.width.toInt(),
                    ),
                  );
                } else {
                  _ad = Container();
                }
                return Column(
                  children: [
                    _ad,
                    ListTile(
                      leading: Container(
                        child: imageItem(
                          data: _enrollList[sectionIndex].members[itemIndex],
                          size: 50,
                        ),
                      ),
                      title: titleItem(
                        data: _enrollList[sectionIndex].members[itemIndex],
                      ),
                      subtitle: Text(
                        _enrollList[sectionIndex].members[itemIndex].jbaid == 0
                            ? '不明'
                            : _enrollList[sectionIndex]
                                .members[itemIndex]
                                .jbaid
                                .toString()
                                .padLeft(9, '0'),
                      ),
                      trailing: roundNumberItem(
                        context: context,
                        team: _enrollList[sectionIndex].team,
                        member: _enrollList[sectionIndex].members[itemIndex],
                      ),
                      onTap: () {
                        MaterialPageRoute materialPageRoute = MaterialPageRoute(
                          builder: (context) => MemberForm(
                            dto: _enrollList[sectionIndex].members[itemIndex],
                            edit: true,
                          ),
                        );
                        Navigator.push(
                          context,
                          materialPageRoute,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    } else {
      return ListView();
    }
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    EnrollDto _enroll = _enrollList[sectionIndex];
    IconData _direction;
    if (_enroll.isSectionExpanded()) {
      _direction = Icons.keyboard_arrow_up;
    } else {
      _direction = Icons.keyboard_arrow_down;
    }
    return InkWell(
      child: Container(
        color: Theme.of(context).toggleableActiveColor,
        height: 48,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 80,
              child: Text(
                _enroll.team.name +
                    '（' +
                    _enroll.members.length.toString() +
                    '名）',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              flex: 20,
              child: Icon(
                _direction,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(
          () {
            _enroll.setSectionExpanded(!_enroll.isSectionExpanded());
          },
        );
      },
    );
  }
}
