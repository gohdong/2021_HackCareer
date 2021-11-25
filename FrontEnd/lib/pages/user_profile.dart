import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  final int userID;

  const UserProfile({Key? key, required this.userID}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(userController.users[widget.userID]!.intro);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/img/profile_background.png').image),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 43, left: 26, right: 26),
              child: appBarContent(
                title: "한양대 ERCIA",
                left: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset('assets/svg/arrow_back.svg'),
                ),
              ),
            ),
            verticalSpacer(220),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                      top: 63,
                      left: 26,
                      right: 26,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0)
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.21),
                            offset: const Offset(0, 3),
                            blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          userController.users[widget.userID]!.nickName,
                          style: CluBTextTheme.bold30
                              .copyWith(color: CluBColor.mainColor),
                        ),
                        verticalSpacer(10),
                        Text(
                          userController.users[widget.userID]!.intro,
                          style: CluBTextTheme.semiBold16_26
                              .copyWith(color: CluBColor.black),
                        ),
                        verticalSpacer(20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "인증정보",
                                style: CluBTextTheme.extraBold18
                                    .copyWith(color: CluBColor.mainColor),
                              ),
                              verticalSpacer(10),
                              Text(
                                  "한양대학교 ERICA캠퍼스\n${userController.users[widget.userID]!.major} ${extractYearOnStudentNumber(userController.users[widget.userID]!.studentNum)}",
                                  style: CluBTextTheme.semiBold14_20
                                      .copyWith(color: CluBColor.black)),
                              verticalSpacer(20),
                              Text("관심분야",
                                  style: CluBTextTheme.extraBold18
                                      .copyWith(color: CluBColor.mainColor)),
                              verticalSpacer(10),
                              Text(
                                convertInterestToHashTag(userController
                                    .users[widget.userID]!.interest),
                                style: CluBTextTheme.semiBold14_20
                                    .copyWith(color: CluBColor.black),
                              ),
                            ],
                          ),
                        ),
                        verticalSpacer(31),
                        Container(
                          height: 78,
                          decoration: BoxDecoration(
                            color: const Color(0xfff7f7f7).withOpacity(0.37),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "만든크루",
                                      style: CluBTextTheme.bold16.copyWith(
                                        color: const Color(0xff525252),
                                      ),
                                    ),
                                    verticalSpacer(5),
                                    Text(
                                      "5",
                                      style: CluBTextTheme.bold20.copyWith(
                                        color: CluBColor.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                width: 0,
                                thickness: 2,
                                color: CluBColor.ultraLightGray,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "크루참여",
                                      style: CluBTextTheme.bold16.copyWith(
                                        color: const Color(0xff525252),
                                      ),
                                    ),
                                    verticalSpacer(5),
                                    Text(
                                      "8",
                                      style: CluBTextTheme.bold20
                                          .copyWith(color: CluBColor.mainColor),
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                width: 0,
                                thickness: 2,
                                color: CluBColor.ultraLightGray,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "크루레벨",
                                      style: CluBTextTheme.bold16.copyWith(
                                        color: const Color(0xff525252),
                                      ),
                                    ),
                                    verticalSpacer(5),
                                    Text(
                                      "Lv. ${userController.users[widget.userID]!.level}",
                                      style: CluBTextTheme.bold20
                                          .copyWith(color: CluBColor.mainColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 65,
                    top: -100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xff9596FF),
                              Color(0xff63D9B0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter),
                      ),
                      child: const Text(
                        "슈퍼크루비",
                        style: CluBTextTheme.bold16,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -100,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.21),
                              offset: const Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          userProfileImg(147, 147),
                          widget.userID == userController.myID
                              ? Positioned(
                                  right: 18,
                                  bottom: -10,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: CluBColor.mainColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.64),
                                            offset: const Offset(0, 3),
                                            blurRadius: 6)
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/svg/camera.svg'),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xffEF7F7A),
                              Color(0xffC1C2FA),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter),
                      ),
                      child: const Text(
                        "백신접종완료",
                        style: CluBTextTheme.bold16,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 65,
                    top: -60,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: CluBColor.mainColor),
                      child: const Text(
                        "매너크루",
                        style: CluBTextTheme.bold16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
