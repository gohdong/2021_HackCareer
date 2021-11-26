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

class MyClubTab extends StatefulWidget {
  const MyClubTab({Key? key}) : super(key: key);

  @override
  State<MyClubTab> createState() => _MyClubTabState();
}

class _MyClubTabState extends State<MyClubTab> {
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
    return Container(
      padding: const EdgeInsets.only(top: 22, bottom: 20),
      child: FutureBuilder<List<Club>>(
          future: getMyLiveClubs(isNow),
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
                        style: CluBTextTheme.medium18
                            .copyWith(color: Colors.white),
                      ),
                      verticalSpacer(8),
                      Text(
                        "참여 중인 ${currentTab == "now"?"NOW":"크루비"} 기록입니다!",
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
                    if (isNow) {
                      return GestureDetector(
                        onTapUp: (e) {
                          Get.to(() => ClubPage(
                                club: snapshot.data![index],
                              ));
                        },
                        onTapDown: (e) {
                          print(e);
                        },
                        onTapCancel: () {
                          print("canceled");
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

                    return GestureDetector(
                      onTapUp: (e) {
                        Get.to(() => ClubPage(
                              club: snapshot.data![index],
                            ));
                      },
                      onTapDown: (e) {
                        print(e);
                      },
                      onTapCancel: () {
                        print("canceled");
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
                    );
                  },
                  separatorBuilder: (context, index) {
                    return verticalSpacer(isNow ? 24 : 12);
                  },
                ),
              ],
            );
          }),
    );
  }
}
