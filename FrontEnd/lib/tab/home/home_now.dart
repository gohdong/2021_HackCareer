import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeNowTab extends StatefulWidget {
  const HomeNowTab({Key? key}) : super(key: key);

  @override
  State<HomeNowTab> createState() => _HomeNowTabState();
}

class _HomeNowTabState extends State<HomeNowTab> {
  int currentCardIndex = 0;
  double varTopPosition = 95;
  double varMidPosition = 20;
  double varBottomPosition = 40;
  final double constTopPosition = 95;
  final double constMidPosition = 20;
  final double constBottomPosition = 40;

  SwipableStackController swipableStackController = SwipableStackController();

  bool turnOnCloseButton = false;
  bool turnOnLikedButton = false;

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
      'title': '4시에 요시고 사진전보러\n5',
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
      'title': '4시에 요시고 사진전보러\n6',
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
      'title': '4시에 요시고 사진전보러\n7',
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
      'title': '4시에 요시고 사진전보러\n8',
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
      'title': '4시에 요시고 사진전보러\n9',
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
      'title': '4시에 요시고 사진전보러\n10',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
  ];

  @override
  void initState() {
    super.initState();
    swipableStackController.addListener(() {
      if (swipableStackController.currentSession != null) {
        double direction = swipableStackController.currentSession!.startPosition.dx -
            swipableStackController.currentSession!.currentPosition.dx;
        if (direction < -30) {
          // swipe right
          setState(() {
            turnOnLikedButton = true;
          });
        } else if (direction > 30) {
          //swipe left
          setState(() {
            turnOnCloseButton = true;
          });
        } else {
          //reset
          setState(() {
            turnOnCloseButton = false;
            turnOnLikedButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    swipableStackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 68,
          width: 68,
          alignment: Alignment.center,
          child: Image.asset('assets/img/floatbutton.png'),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          color: CluBColor.mainBackground,
          child: newDeck()),
    );
  }

  Widget newDeck() {
    if (currentCardIndex >= data.length) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/luby_gray.svg',
            width: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "지금은 NOW 모임이 없어요!",
            style: CluBTextTheme.medium18.copyWith(color: CluBColor.lightGray),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 26, bottom: 20, top: 18),
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
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              currentCardIndex + 3 < data.length
                  ? Positioned(
                      top: constBottomPosition,
                      child: AnimatedOpacity(
                        duration: varBottomPosition == constBottomPosition
                            ? Duration(milliseconds: 0)
                            : Duration(milliseconds: 500),
                        opacity:
                            varBottomPosition == constBottomPosition ? 0 : 1,
                        child: Transform.scale(
                          scale: 0.9,
                          child: BigCard(
                            title: data[currentCardIndex + 3]['title'],
                            category: data[currentCardIndex + 3]['category'],
                            desc: data[currentCardIndex + 3]['desc'],
                            img: data[currentCardIndex + 3]['img'],
                            leader: data[currentCardIndex + 3]['leader'],
                            leaderSchoolNum: data[currentCardIndex + 3]
                                ['leaderSchoolNum'],
                            maxMemberCount: data[currentCardIndex + 3]
                                ['maxMemberCount'],
                            memberCount: data[currentCardIndex + 3]
                                ['memberCount'],
                            time: data[currentCardIndex + 3]['time'],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              currentCardIndex + 2 < data.length
                  ? AnimatedPositioned(
                      duration: varBottomPosition == constMidPosition
                          ? Duration(milliseconds: 500)
                          : Duration(milliseconds: 0),
                      top: varBottomPosition,
                      child: AnimatedScale(
                        duration: varBottomPosition == constMidPosition
                            ? Duration(milliseconds: 500)
                            : Duration(milliseconds: 0),
                        scale: varBottomPosition == constBottomPosition
                            ? 0.9
                            : 0.95,
                        child: BigCard(
                          title: data[currentCardIndex + 2]['title'],
                          category: data[currentCardIndex + 2]['category'],
                          desc: data[currentCardIndex + 2]['desc'],
                          img: data[currentCardIndex + 2]['img'],
                          leader: data[currentCardIndex + 2]['leader'],
                          leaderSchoolNum: data[currentCardIndex + 2]
                              ['leaderSchoolNum'],
                          maxMemberCount: data[currentCardIndex + 2]
                              ['maxMemberCount'],
                          memberCount: data[currentCardIndex + 2]
                              ['memberCount'],
                          time: data[currentCardIndex + 2]['time'],
                        ),
                      ),
                    )
                  : Container(),
              currentCardIndex + 1 < data.length
                  ? AnimatedPositioned(
                      duration: varMidPosition == constMidPosition
                          ? Duration(milliseconds: 0)
                          : Duration(milliseconds: 500),
                      top: varMidPosition,
                      child: AnimatedScale(
                        duration: varMidPosition == constMidPosition
                            ? Duration(milliseconds: 0)
                            : Duration(milliseconds: 500),
                        scale: varMidPosition == constMidPosition ? 0.95 : 1,
                        child: BigCard(
                          title: data[currentCardIndex + 1]['title'],
                          category: data[currentCardIndex + 1]['category'],
                          desc: data[currentCardIndex + 1]['desc'],
                          img: data[currentCardIndex + 1]['img'],
                          leader: data[currentCardIndex + 1]['leader'],
                          leaderSchoolNum: data[currentCardIndex + 1]
                              ['leaderSchoolNum'],
                          maxMemberCount: data[currentCardIndex + 1]
                              ['maxMemberCount'],
                          memberCount: data[currentCardIndex + 1]
                              ['memberCount'],
                          time: data[currentCardIndex + 1]['time'],
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                top: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 537,
                  child: SwipableStack(
                    controller: swipableStackController,
                    onSwipeCompleted: (index, direction) {
                      print(direction);
                      cardUp();
                    },
                    allowVerticalSwipe: false,
                    itemCount: data.length,
                    viewFraction: 1,
                    builder: (context, index, constraints) {
                      return SizedBox(
                        width: 376,
                        child: Center(
                          child: BigCard(
                              category: data[index]['category'],
                              leader: data[index]['leader'],
                              leaderSchoolNum: data[index]['leaderSchoolNum'],
                              title: data[index]['title'],
                              desc: data[index]['desc'],
                              img: data[index]['img'],
                              memberCount: data[index]['memberCount'],
                              maxMemberCount: data[index]['maxMemberCount'],
                              time: data[index]['time']),
                        ),
                      );
                    },
                  ),
                ),
              ),
              currentCardIndex < data.length
                  ? Positioned(
                      top: 467,
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
                    )
                  : Container(),
              currentCardIndex < data.length
                  ? Positioned(
                      top: 467,
                      left: 79,
                      child: InkWell(
                        onTap: () {
                          swipableStackController.next(swipeDirection: SwipeDirection.left);
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: turnOnCloseButton
                                  ? CluBColor.subPurple
                                  : CluBColor.black,
                              border: Border.all(
                                  color: CluBColor.subPurple, width: 1.5)),
                          child: SvgPicture.asset(
                            'assets/svg/close.svg',
                            width: 35,
                            color: turnOnCloseButton
                                ? Colors.white
                                : CluBColor.subPurple,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              currentCardIndex < data.length
                  ? Positioned(
                      top: 467,
                      right: 79,
                      child: InkWell(
                        onTap: () {
                          swipableStackController.next(swipeDirection: SwipeDirection.right);
                        },
                        child: Container(
                          height: 65,
                          width: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: turnOnLikedButton
                                  ? CluBColor.subGreen
                                  : CluBColor.black,
                              border: Border.all(
                                  color: CluBColor.subGreen, width: 1.5)),
                          child: SvgPicture.asset(
                            'assets/svg/heart.svg',
                            width: 35,
                            color: turnOnLikedButton
                                ? Colors.white
                                : CluBColor.subGreen,
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }

  void cardUp() {
    setState(() {
      turnOnLikedButton = false;
      turnOnCloseButton = false;
      varTopPosition = 0;
      varMidPosition = 0;
      varBottomPosition = constMidPosition;
      currentCardIndex += 1;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      print('delay');
    }).then((value) {
      setState(() {
        varTopPosition = 95;
        varMidPosition = constMidPosition;
        varBottomPosition = constBottomPosition;
      });
    });
  }
}
