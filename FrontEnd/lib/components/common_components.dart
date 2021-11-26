import 'dart:ui';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/my_info.dart';
import 'package:clu_b/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget horizontalSpacer(double width) {
  return SizedBox(
    width: width,
  );
}

Widget verticalSpacer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget categoryIndicator(String category) {
  return Container(
    width: 65,
    height: 27,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: CluBColor.subGreen, borderRadius: BorderRadius.circular(27)),
    child: Text(
      category,
      style: CluBTextTheme.bold18.copyWith(color: Colors.white),
    ),
  );
}

Widget feedCategoryIndicator(String category) {
  return Container(
    width: 52,
    height: 23,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: CluBColor.mainColor, borderRadius: BorderRadius.circular(27)),
    child: Text(
      category,
      style: CluBTextTheme.bold16,
    ),
  );
}

Widget memberIndicator(int memberCount, int maxMemberCount) {
  return Container(
    width: 83,
    height: 28,
    margin: const EdgeInsets.only(top: 5.5),
    decoration: BoxDecoration(
        color: CluBColor.darkGray, borderRadius: BorderRadius.circular(14)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$memberCount",
          style: CluBTextTheme.extraBold18.copyWith(color: Colors.white),
        ),
        Text(
          "/",
          style: CluBTextTheme.extraBold18
              .copyWith(color: CluBColor.ultraLightGray),
        ),
        Text(
          "$maxMemberCount",
          style: CluBTextTheme.extraBold18
              .copyWith(color: CluBColor.ultraLightGray),
        ),
      ],
    ),
  );
}

Widget smallMemberIndicator(int memberCount, int maxMemberCount) {
  return Container(
    width: 58,
    height: 23,
    decoration: BoxDecoration(
        color: CluBColor.darkGray, borderRadius: BorderRadius.circular(14)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$memberCount",
          style: CluBTextTheme.bold16.copyWith(color: Colors.white),
        ),
        Text(
          "/",
          style: CluBTextTheme.bold16.copyWith(color: CluBColor.ultraLightGray),
        ),
        Text(
          "$maxMemberCount",
          style: CluBTextTheme.bold16.copyWith(color: CluBColor.ultraLightGray),
        ),
      ],
    ),
  );
}

Widget leaderIndicatorSummary(User leader) {
  return Stack(
    alignment: Alignment.centerLeft,
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 64.3,
        height: 26.6,
        padding: const EdgeInsets.only(right: 9),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: CluBColor.darkGray,
          // image: DecorationImage(
          //   image: Image
          // ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          extractYearOnStudentNumber(leader.studentNum),
          style: CluBTextTheme.bold16.copyWith(
              fontWeight: FontWeight.w800, color: CluBColor.mainColor),
        ),
      ),
      Positioned(
        left: -12,
        child: userProfileImg(46, 46, img: leader.imgPath),
      ),
    ],
  );
}

Widget smallLeaderIndicator(User leader) {
  return Stack(
    alignment: Alignment.centerLeft,
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 63,
        height: 26,
        margin: const EdgeInsets.only(left: 5),
        padding: const EdgeInsets.only(right: 9),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: CluBColor.darkGray,
          // image: DecorationImage(
          //   image: Image
          // ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          extractYearOnStudentNumber(leader.studentNum),
          style: CluBTextTheme.bold16.copyWith(
              fontWeight: FontWeight.w800, color: CluBColor.mainColor),
        ),
      ),
      Positioned(
        left: 0,
        child: userProfileImg(36, 36, img: leader.imgPath),
      )
    ],
  );
}

Widget timeIndicator(DateTime time) {
  return Column(
    children: [
      Text(12 <= time.hour && time.hour <= 23 ? "오후" : "오전",
          style: CluBTextTheme.extraBold14.copyWith(color: Colors.white)),
      Text(
          "${12 <= time.hour && time.hour <= 23 ? time.hour - 12 : time.hour}시",
          style: CluBTextTheme.bold30.copyWith(color: Colors.white)),
      const SizedBox(
        width: 48,
        child: Divider(
          color: CluBColor.subGreen,
          thickness: 2,
          height: 16,
        ),
      ),
      Text("남은시간",
          style: CluBTextTheme.extraBold14.copyWith(color: CluBColor.subGreen)),
      Text(
        time.difference(DateTime.now()).isNegative
            ? "종료됨"
            : time.difference(DateTime.now()).toString().split('.')[0],
        style: CluBTextTheme.bold30.copyWith(
            color: time.difference(DateTime.now()).isNegative
                ? CluBColor.gray
                : CluBColor.subGreen),
      ),
    ],
  );
}

Widget smallTabIndicator(bool activated, String text) {
  return Container(
    alignment: Alignment.center,
    width: 63,
    height: 26,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: activated ? CluBColor.mainColor : null),
    child: Text(
      text,
      style: CluBTextTheme.semiBold18.copyWith(
          color: activated ? CluBColor.mainBackground : CluBColor.mainColor),
    ),
  );
}

Widget dateIndicator(DateTime date) {
  return Container(
    width: 60,
    height: 52,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.white.withOpacity(0.76)),
    child: BackdropFilter(
      filter: ImageFilter.blur(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekDayToString(date.weekday),
              style: CluBTextTheme.extraBold14
                  .copyWith(color: CluBColor.mainColor),
            ),
            Text(
              "${date.day}",
              style: CluBTextTheme.extraBold26
                  .copyWith(color: CluBColor.mainColor),
            )
          ],
        ),
      ),
    ),
  );
}

Widget dateIndicatorGray(DateTime date) {
  return Container(
    width: 56,
    height: 52,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11), color: CluBColor.gray),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weekDayToString(date.weekday),
          style: CluBTextTheme.extraBold14.copyWith(color: CluBColor.subGreen),
        ),
        Text(
          "${date.day}",
          style: CluBTextTheme.extraBold26.copyWith(color: CluBColor.subGreen),
        )
      ],
    ),
  );
}

Widget clubInfo(Club? club, {bool eclipseTitle = true}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              club!.title,
              style: CluBTextTheme.bold22_30,
              overflow: eclipseTitle ? TextOverflow.ellipsis : null,
              maxLines: eclipseTitle ? 1 : null,
            ),
            verticalSpacer(8),
            Row(
              children: [
                categoryIndicator(club.category),
                horizontalSpacer(8),
                Expanded(
                  child: SizedBox(
                    height: 23,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          club.hashTags.length > 3 ? 3 : club.hashTags.length,
                      itemBuilder: (context, index) => Center(
                        child: Text(
                          "#${club.hashTags[index]}",
                          style: CluBTextTheme.bold16
                              .copyWith(color: CluBColor.subGreen),
                        ),
                      ),
                      separatorBuilder: (context, index) => horizontalSpacer(8),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallMemberIndicator(club.memberCount, club.numLimit),
            horizontalSpacer(12),
            dateIndicatorGray(
              club.timeLimit,
            )
          ],
        ),
      )
    ],
  );
}

Widget userProfileImg(double width, double height, {String? img}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: CluBColor.darkGray,
      image: img != null
          ? DecorationImage(image: Image.asset(img).image, fit: BoxFit.contain)
          : DecorationImage(
              image: Image.asset('assets/img/default_profile.png').image,
              fit: BoxFit.contain),
    ),
  );
}

Widget userProfileInChat(User? user) {
  //TODO USER
  return Row(
    children: [
      userProfileImg(36, 36, img: user!.imgPath),
      horizontalSpacer(8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.nickName,
            style: CluBTextTheme.semiBold14_20.copyWith(height: 1),
          ),
          Text(
            "${user.major} ${extractYearOnStudentNumber(user.studentNum)}",
            style: CluBTextTheme.medium12.copyWith(color: CluBColor.mainColor),
          )
        ],
      )
    ],
  );
}

Widget appBarContent({Widget? left, Widget? right, String? title}) {
  return SizedBox(
    height: 30,
    child: Row(
      children: [
        Expanded(
          child: Align(alignment: Alignment.centerLeft, child: left),
        ),
        Expanded(
          child: title != null
              ? Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xffC1C1FF),
                    ),
                  ),
                )
              : Container(),
        ),
        Expanded(
          child: Align(alignment: Alignment.centerRight, child: right),
        ),
      ],
    ),
  );
}

Widget notificationIndicator(bool gotNew) {
  return Stack(
    children: [
      SvgPicture.asset('assets/svg/bell.svg'),
      gotNew
          ? Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 5.5,
                height: 5.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CluBColor.subGreen,
                ),
              ),
            )
          : Container()
    ],
  );
}
