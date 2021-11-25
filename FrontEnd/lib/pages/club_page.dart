import 'dart:ui';

import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/data/club2.dart';
import 'package:clu_b/data/user.dart';
import 'package:clu_b/pages/chatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ClubPage extends StatefulWidget {
  final Club2 club;

  const ClubPage({Key? key, required this.club}) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final ClubController clubController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: CluBColor.mainBackground,
            padding: const EdgeInsets.only(bottom: 90),
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  height: 352,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/img/IMG_4624.png').image)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 26, right: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clubInfo(widget.club, eclipseTitle: false),
                      verticalSpacer(30),
                      //TODO USER INDICATOR
                      Row(
                        children: [
                          userProfileImg(48, 48,
                              img: widget.club.leader.imgPath),
                          horizontalSpacer(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.club.leader.nickName,
                                style: CluBTextTheme.bold16,
                              ),
                              Text(
                                "${widget.club.leader.major} ${extractYearOnStudentNumber(widget.club.leader.studentNum)}",
                                style: CluBTextTheme.semiBold14_20
                                    .copyWith(color: CluBColor.mainColor),
                              )
                            ],
                          )
                        ],
                      ),
                      verticalSpacer(20),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        color: CluBColor.darkGray,
                      ),
                      verticalSpacer(12),
                      Text(
                        widget.club.description,
                        style: CluBTextTheme.semiBold16_26,
                      ),
                      verticalSpacer(50),
                      const Divider(
                        height: 0,
                        thickness: 2,
                        color: CluBColor.darkGray,
                      ),
                      verticalSpacer(8),
                      Text(
                        "참여자",
                        style: CluBTextTheme.bold16
                            .copyWith(color: CluBColor.darkGray),
                      ),
                      verticalSpacer(8),
                      SizedBox(
                        height: 36,
                        child: FutureBuilder<List<User>>(
                            future: getClubMembers(widget.club.id),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Align(
                                    widthFactor: 0.75,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: const Offset(0, 3),
                                              blurRadius: 6)
                                        ],
                                      ),
                                      child: userProfileImg(36, 36,
                                          img: snapshot.data![index].imgPath),
                                    ),
                                  );
                                },
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            // 상단 앱바
            height: 110,
            padding: EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Colors.black.withOpacity(0)],
              ),
            ),
            child: appBarContent(
              left: InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  'assets/svg/arrow_back.svg',
                  width: 27,
                ),
              ),
              right: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/share.svg',
                      width: 27,
                    ),
                  ),
                  horizontalSpacer(18),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/heart_outlined.svg',
                      width: 27,
                    ),
                  ),
                  horizontalSpacer(18),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/more.svg',
                      color: CluBColor.ultraLightGray,
                      width: 27,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 27,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 52,
              margin: const EdgeInsets.symmetric(horizontal: 26),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: CluBColor.black,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.63),
                      offset: const Offset(6, 6),
                      blurRadius: 12)
                ],
                border: Border.all(
                    color: CluBColor.mainColor.withOpacity(0.11), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 103,
                    height: 35,
                    decoration: BoxDecoration(
                      color: CluBColor.gray,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/people.svg'),
                        horizontalSpacer(5.5),
                        Text(
                          "${widget.club.memberCount}",
                          style: CluBTextTheme.bold16
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "/",
                          style: CluBTextTheme.bold16
                              .copyWith(color: CluBColor.ultraLightGray),
                        ),
                        Text(
                          "${widget.club.numLimit}",
                          style: CluBTextTheme.bold16
                              .copyWith(color: CluBColor.ultraLightGray),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => ChattingRoom(
                          club: widget.club,
                        ),
                      );
                    },
                    child: Container(
                      width: 103,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: CluBColor.mainColor, width: 2)),
                      child: Center(
                        child: Text(
                          "참여하기",
                          style: CluBTextTheme.bold16
                              .copyWith(color: CluBColor.mainColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
