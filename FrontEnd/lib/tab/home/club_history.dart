import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/components/small_card.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/pages/club_page.dart';
import 'package:clu_b/tab/home/home_club.dart';
import 'package:clu_b/tab/home/home_now.dart';
import 'package:clu_b/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ClubHistoryTab extends StatefulWidget {
  const ClubHistoryTab({Key? key}) : super(key: key);

  @override
  State<ClubHistoryTab> createState() => _ClubHistoryTabState();
}

class _ClubHistoryTabState extends State<ClubHistoryTab> {
  String currentTab = "now";
  UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CluBColor.mainBackground,
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
                    getMyClubLog(false).then((value) {
                      print(value.length);
                    });
                    setState(() {
                      currentTab = "now";
                    });
                  },
                  child: smallTabIndicator(currentTab == "now", "NOW"),
                ),
                horizontalSpacer(10),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentTab = "club";
                    });
                  },
                  child: smallTabIndicator(currentTab == "club", "크루비"),
                )
              ],
            ),
          ),
          Expanded(
            child: myClubBody(currentTab == 'now'),
          )
        ],
      ),
    );
  }

  Widget myClubBody(bool isNow) {
    Map<int, bool> test = {};
    return Container(
      padding: const EdgeInsets.only(top: 22, bottom: 20),
      child: FutureBuilder<List<Club>>(
        future: getMyClubLog(isNow),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
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
                    "참여한 모임이 없어요!",
                    style: CluBTextTheme.medium18
                        .copyWith(color: CluBColor.lightGray),
                  ),
                  verticalSpacer(
                    100,
                  ),
                ],
              ),
            );
          }

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, top: 22, bottom: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "안녕하세요, ${userController.me()!.nickName}님",
                      style:
                          CluBTextTheme.medium18.copyWith(color: Colors.white),
                    ),
                    verticalSpacer(8),
                    Text(
                      "${currentTab == "now" ? "NOW" : "크루비"} 기록입니다!",
                      style: CluBTextTheme.extraBold18
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  test[index] = false;
                  if (isNow) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ClubPage(
                              club: snapshot.data![index],
                            ));
                      },
                      child: SizedBox(
                        width: 376,
                        child: Center(
                          child: BigCard(
                            title: snapshot.data![index].title,
                            category: snapshot.data![index].category,
                            desc: snapshot.data![index].description,
                            img: snapshot.data![index].imagePath,
                            leader: snapshot.data![index].leader,
                            maxMemberCount: snapshot.data![index].numLimit,
                            memberCount: snapshot.data![index].memberCount,
                            time: snapshot.data![index].timeLimit,
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      snapshot.data![index].isCanceled
                          ? canceledClub(snapshot.data![index], index)
                          : GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ClubPage(
                                    club: snapshot.data![index],
                                  ),
                                );
                              },
                              child: SmallCard(
                                title: snapshot.data![index].title,
                                category: snapshot.data![index].category,
                                desc: snapshot.data![index].description,
                                img: snapshot.data![index].imagePath,
                                leader: snapshot.data![index].leader,
                                maxMemberCount: snapshot.data![index].numLimit,
                                memberCount: snapshot.data![index].memberCount,
                                time: snapshot.data![index].timeLimit,
                                left: index % 2 == 1,
                              ),
                            ),
                      Container(
                        height: 54,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CluBColor.mainBackground,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                offset: const Offset(0, 3),
                                blurRadius: 6),
                          ],
                        ),
                        child: snapshot.data![index].isCanceled
                            ? Text(
                                "취소된 크루",
                                style: CluBTextTheme.bold20.copyWith(
                                  color: CluBColor.darkGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "크루평가 남기기",
                                style: CluBTextTheme.bold20.copyWith(
                                  color: CluBColor.mainColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpacer(isNow ? 24 : 12);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget canceledClub(Club club, index) {
    bool showMask = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () {
            setState(() {
              showMask = !showMask;
            });
          },
          child: Stack(
            children: [
              SmallCard(
                title: club.title,
                category: club.category,
                desc: club.description,
                img: club.imagePath,
                leader: club.leader,
                maxMemberCount: club.numLimit,
                memberCount: club.memberCount,
                time: club.timeLimit,
                left: index % 2 == 1,
              ),
              showMask
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.64,
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff272727),
                              borderRadius: BorderRadius.circular(11)
                            ),
                            width: 122,
                            height: 85,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svg/report.svg',width: 37,),
                                const Text("신고하기",style: CluBTextTheme.bold18,)
                              ],
                            ),
                          ),
                          horizontalSpacer(10),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xff272727),
                                borderRadius: BorderRadius.circular(11)
                            ),
                            width: 122,
                            height: 85,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svg/delete.svg',width: 37,),
                                const Text("지우기",style: CluBTextTheme.bold18,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
