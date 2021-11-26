import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/pages/chatting.dart';
import 'package:clu_b/pages/club_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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

  final ClubController clubController = Get.find();

  @override
  void initState() {
    super.initState();
    swipableStackController.addListener(() {
      if (swipableStackController.currentSession != null) {
        double direction =
            swipableStackController.currentSession!.startPosition.dx -
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
        onTap: () async {
          // print(clubController.joinedClub);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 68,
          width: 68,
          alignment: Alignment.center,
          child: Image.asset('assets/img/floatbutton.png'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: CluBColor.mainBackground,
        child: newDeck(),
      ),
    );
  }

  Widget newDeck() {
    return FutureBuilder<List<Club>>(
      future: getClubs(isNow: true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          List<Club> filteredSnapshot = snapshot.data!
              .where((element) =>
                  !clubController.likedClub.containsKey(element.id))
              .where((element) =>
                  !clubController.joinedClub.containsKey(element.id))
              .toList();


          if (currentCardIndex >= filteredSnapshot.length) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/luby_gray.svg',
                  width: 100,
                ),
                verticalSpacer(
                  20,
                ),
                Text(
                  "지금은 NOW 모임이 없어요!",
                  style: CluBTextTheme.medium18
                      .copyWith(color: CluBColor.lightGray),
                ),
                verticalSpacer(
                  100,
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, bottom: 20, top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NOW 크루비",
                      style: CluBTextTheme.extraBold18
                          .copyWith(color: Colors.white),
                    ),
                    verticalSpacer(8),
                    Text(
                      "3시간 이내의 모임",
                      style:
                          CluBTextTheme.medium18.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    currentCardIndex + 3 < filteredSnapshot.length
                        ? Positioned(
                            top: constBottomPosition,
                            child: AnimatedOpacity(
                              duration: varBottomPosition == constBottomPosition
                                  ? const Duration(milliseconds: 0)
                                  : const Duration(milliseconds: 500),
                              opacity: varBottomPosition == constBottomPosition
                                  ? 0
                                  : 1,
                              child: Transform.scale(
                                scale: 0.9,
                                child: BigCard(
                                  title: snapshot
                                      .data![currentCardIndex + 3].title,
                                  category: snapshot
                                      .data![currentCardIndex + 3].category,
                                  desc: snapshot
                                      .data![currentCardIndex + 3].description,
                                  img: snapshot
                                      .data![currentCardIndex + 3].imagePath,
                                  leader: snapshot
                                      .data![currentCardIndex + 3].leader,
                                  maxMemberCount: snapshot
                                      .data![currentCardIndex + 3].numLimit,
                                  memberCount: snapshot
                                      .data![currentCardIndex + 3].memberCount,
                                  time: snapshot
                                      .data![currentCardIndex + 3].timeLimit,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    currentCardIndex + 2 < filteredSnapshot.length
                        ? AnimatedPositioned(
                            duration: varBottomPosition == constMidPosition
                                ? const Duration(milliseconds: 500)
                                : const Duration(milliseconds: 0),
                            top: varBottomPosition,
                            child: AnimatedScale(
                              duration: varBottomPosition == constMidPosition
                                  ? const Duration(milliseconds: 500)
                                  : const Duration(milliseconds: 0),
                              scale: varBottomPosition == constBottomPosition
                                  ? 0.9
                                  : 0.95,
                              child: BigCard(
                                title: filteredSnapshot[currentCardIndex + 2]
                                    .title,
                                category: filteredSnapshot[currentCardIndex + 2]
                                    .category,
                                desc: filteredSnapshot[currentCardIndex + 2]
                                    .description,
                                img: filteredSnapshot[currentCardIndex + 2]
                                    .imagePath,
                                leader: filteredSnapshot[currentCardIndex + 2]
                                    .leader,
                                maxMemberCount:
                                    filteredSnapshot[currentCardIndex + 2]
                                        .numLimit,
                                memberCount:
                                    filteredSnapshot[currentCardIndex + 2]
                                        .memberCount,
                                time: filteredSnapshot[currentCardIndex + 2]
                                    .timeLimit,
                              ),
                            ),
                          )
                        : Container(),
                    currentCardIndex + 1 < filteredSnapshot.length
                        ? AnimatedPositioned(
                            duration: varMidPosition == constMidPosition
                                ? const Duration(milliseconds: 0)
                                : const Duration(milliseconds: 500),
                            top: varMidPosition,
                            child: AnimatedScale(
                              duration: varMidPosition == constMidPosition
                                  ? const Duration(milliseconds: 0)
                                  : const Duration(milliseconds: 500),
                              scale:
                                  varMidPosition == constMidPosition ? 0.95 : 1,
                              child: BigCard(
                                title: filteredSnapshot[currentCardIndex + 1]
                                    .title,
                                category: filteredSnapshot[currentCardIndex + 1]
                                    .category,
                                desc: filteredSnapshot[currentCardIndex + 1]
                                    .description,
                                img: filteredSnapshot[currentCardIndex + 1]
                                    .imagePath,
                                leader: filteredSnapshot[currentCardIndex + 1]
                                    .leader,
                                maxMemberCount:
                                    filteredSnapshot[currentCardIndex + 1]
                                        .numLimit,
                                memberCount:
                                    filteredSnapshot[currentCardIndex + 1]
                                        .memberCount,
                                time: filteredSnapshot[currentCardIndex + 1]
                                    .timeLimit,
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
                            cardUp(filteredSnapshot[currentCardIndex]);
                          },
                          allowVerticalSwipe: false,
                          itemCount: filteredSnapshot.length,
                          viewFraction: 1,
                          builder: (context, index, constraints) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ClubPage(
                                    club: filteredSnapshot[currentCardIndex],
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 376,
                                child: Center(
                                  child: BigCard(
                                    title: filteredSnapshot[currentCardIndex]
                                        .title,
                                    category: filteredSnapshot[currentCardIndex]
                                        .category,
                                    desc: filteredSnapshot[currentCardIndex]
                                        .description,
                                    img: filteredSnapshot[currentCardIndex]
                                        .imagePath,
                                    leader: filteredSnapshot[currentCardIndex]
                                        .leader,
                                    maxMemberCount:
                                        filteredSnapshot[currentCardIndex]
                                            .numLimit,
                                    memberCount:
                                        filteredSnapshot[currentCardIndex]
                                            .memberCount,
                                    time: filteredSnapshot[currentCardIndex]
                                        .timeLimit,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    currentCardIndex < filteredSnapshot.length
                        ? Positioned(
                            top: 467,
                            child: InkWell(
                              onTap: () {
                                customDialog(
                                  context: context,
                                  title: "NOW 참여",
                                  content:
                                      "${filteredSnapshot[currentCardIndex].title}에 참가하시겠습니까?",
                                  confirm: "참가",
                                  cancel: "취소",
                                  onConfirm: () async {
                                    joinClub(filteredSnapshot[currentCardIndex]
                                            .id)
                                        .then((value) {
                                      if (value) {
                                        Get.back();
                                        Get.to(
                                          () => ChattingRoom(
                                            club: snapshot
                                                .data![currentCardIndex],
                                          ),
                                        );
                                      } else {
                                        Get.back();
                                        Get.snackbar(
                                            "오류발생", "알 수 없는 오류가 발생했습니다.");
                                      }
                                    });
                                  },
                                );
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CluBColor.black,
                                  border: Border.all(
                                      color: CluBColor.mainColor, width: 1.5),
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/luby_colored.svg',
                                  width: 37,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    currentCardIndex < filteredSnapshot.length
                        ? Positioned(
                            top: 467,
                            left: 79,
                            child: InkWell(
                              onTap: () {
                                swipableStackController.next(
                                    swipeDirection: SwipeDirection.left);
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
                                        color: CluBColor.subPurple,
                                        width: 1.5)),
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
                    currentCardIndex < filteredSnapshot.length
                        ? Positioned(
                            top: 467,
                            right: 79,
                            child: InkWell(
                              onTap: () {
                                swipableStackController.next(
                                    swipeDirection: SwipeDirection.right);
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

        return Container();
      },
    );
  }

  void cardUp(Club club) {
    if (turnOnLikedButton) {
      clubController.likeClub(club);
    }
    setState(() {
      turnOnLikedButton = false;
      turnOnCloseButton = false;
      varTopPosition = 0;
      varMidPosition = 0;
      varBottomPosition = constMidPosition;
      currentCardIndex += 1;
    });
    Future.delayed(const Duration(milliseconds: 500), () {}).then((value) {
      setState(() {
        varTopPosition = 95;
        varMidPosition = constMidPosition;
        varBottomPosition = constBottomPosition;
      });
    });
  }
}
