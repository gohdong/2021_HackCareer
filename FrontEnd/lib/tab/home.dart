import 'dart:io';
import 'dart:ui';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

List<Map> dummyData = [
  {
    'category': '전시',
    'leader': 'aa',
    'leaderSchoolNum': 17,
    'title': '4시에 요시고 사진전보러\n긱사에서 같이가실분~??',
    'desc': '엣헴 선배랑 같이 보러가자',
    'img': 'assets/img/',
    'memberCount': 2,
    'maxMemberCount': 4,
    'time': DateTime.now().add(Duration(hours: 4))
  },
];

class _HomeTabState extends State<HomeTab> {
  double topPosition = 95;
  double midPosition = 120;
  double bottomPosition = 145;
  var hidden;
  String currentTab = "now";

  List data = [
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n2',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n3',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n4',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        child: Container(
          height: 80,
          width: 80,
          alignment: Alignment.center,
          child: Image.asset('assets/img/floatbutton.png'),
        ),
      ),
      body: Container(
        color: CluBColor.mainBackground,
        padding: EdgeInsets.only(left: 26, right: 26),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy < -500) {
              // up
              print("up");
              cardUp();
            } else if (details.velocity.pixelsPerSecond.dy > 500) {
              print("down");
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentTab = "now";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 63,
                        height: 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: currentTab == "now"
                                ? CluBColor.mainColor
                                : null),
                        child: Text(
                          "NOW",
                          style: CluBTextTheme.semiBold18.copyWith(
                              color: currentTab == "now"
                                  ? CluBColor.mainBackground
                                  : CluBColor.mainColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentTab = "club";
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: 63,
                        height: 26,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: currentTab == "club"
                                ? CluBColor.mainColor
                                : null),
                        child: Text(
                          "크루비",
                          style: CluBTextTheme.semiBold18.copyWith(
                              color: currentTab == "club"
                                  ? CluBColor.mainBackground
                                  : CluBColor.mainColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: currentTab == 'now' ? deck() : Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget deck() {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Positioned(
          top: 145,
          child: AnimatedOpacity(
            duration: bottomPosition == 145
                ? Duration(milliseconds: 0)
                : Duration(milliseconds: 500),
            opacity: bottomPosition == 145 ? 0 : 1,
            child: Transform.scale(
              scale: 0.9,
              child: BigCard(
                title: data[3]['title'],
                category: data[3]['category'],
                desc: data[3]['desc'],
                img: data[3]['img'],
                leader: data[3]['leader'],
                leaderSchoolNum: data[3]['leaderSchoolNum'],
                maxMemberCount: data[3]['maxMemberCount'],
                memberCount: data[3]['memberCount'],
                time: data[3]['time'],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: bottomPosition == 120
              ? Duration(milliseconds: 500)
              : Duration(milliseconds: 0),
          top: bottomPosition,
          child: AnimatedScale(
            duration: bottomPosition == 120
                ? Duration(milliseconds: 500)
                : Duration(milliseconds: 0),
            scale: bottomPosition == 145 ? 0.9 : 0.95,
            child: BigCard(
              title: data[2]['title'],
              category: data[2]['category'],
              desc: data[2]['desc'],
              img: data[2]['img'],
              leader: data[2]['leader'],
              leaderSchoolNum: data[2]['leaderSchoolNum'],
              maxMemberCount: data[2]['maxMemberCount'],
              memberCount: data[2]['memberCount'],
              time: data[2]['time'],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: midPosition == 95
              ? Duration(milliseconds: 500)
              : Duration(milliseconds: 0),
          top: midPosition,
          child: AnimatedScale(
            duration: midPosition == 95
                ? Duration(milliseconds: 500)
                : Duration(milliseconds: 0),
            scale: midPosition == 120 ? 0.95 : 1,
            child: BigCard(
              title: data[1]['title'],
              category: data[1]['category'],
              desc: data[1]['desc'],
              img: data[1]['img'],
              leader: data[1]['leader'],
              leaderSchoolNum: data[1]['leaderSchoolNum'],
              maxMemberCount: data[1]['maxMemberCount'],
              memberCount: data[1]['memberCount'],
              time: data[1]['time'],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: topPosition == 0
              ? Duration(milliseconds: 500)
              : Duration(milliseconds: 0),
          top: topPosition,
          child: AnimatedOpacity(
            duration: topPosition == 0
                ? Duration(milliseconds: 500)
                : Duration(milliseconds: 0),
            opacity: topPosition == 0 ? 0 : 1,
            child: AnimatedScale(
              duration: topPosition == 0
                  ? Duration(milliseconds: 500)
                  : Duration(milliseconds: 0),
              scale: topPosition == 0 ? 0.9 : 1,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  BigCard(
                    title: data[0]['title'],
                    category: data[0]['category'],
                    desc: data[0]['desc'],
                    img: data[0]['img'],
                    leader: data[0]['leader'],
                    leaderSchoolNum: data[0]['leaderSchoolNum'],
                    maxMemberCount: data[0]['maxMemberCount'],
                    memberCount: data[0]['memberCount'],
                    time: data[0]['time'],
                  ),
                  Positioned(
                    bottom: -11,
                    child: Container(
                      height: 80,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CluBColor.black,
                          border: Border.all(
                              color: CluBColor.mainColor, width: 1.5)),
                      child: SvgPicture.asset(
                        'assets/svg/luby_colored.svg',
                        width: 37,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 53,
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CluBColor.black,
                          border: Border.all(
                              color: CluBColor.subPurple, width: 1.5)),
                      child: SvgPicture.asset(
                        'assets/svg/close.svg',
                        width: 35,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 53,
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CluBColor.black,
                          border: Border.all(
                              color: CluBColor.subGreen, width: 1.5)),
                      child: SvgPicture.asset(
                        'assets/svg/heart.svg',
                        width: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NOW 크루비",
                style: CluBTextTheme.extraBold18.copyWith(color: Colors.white),
              ),
              Text(
                "3시간 이내의 모임",
                style: CluBTextTheme.medium18.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void cardUp() {
    setState(() {
      topPosition = 0;
      midPosition = 95;
      bottomPosition = 120;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      print('delay');
    }).then((value) {
      data.removeAt(0);
      print("removed");
      setState(() {
        topPosition = 95;
        midPosition = 120;
        bottomPosition = 145;
      });
    });
  }
}
