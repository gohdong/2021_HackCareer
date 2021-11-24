import 'dart:ui';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/user.dart';
import 'package:flutter/material.dart';

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

Widget leaderIndicatorSummary(String imgPath, int leaderSchoolNum) {
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
          "$leaderSchoolNum",
          style: CluBTextTheme.bold16.copyWith(
              fontWeight: FontWeight.w800, color: CluBColor.mainColor),
        ),
      ),
      Positioned(
        left: -12,
        child: Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
                color: CluBColor.gray, shape: BoxShape.circle)),
      )
    ],
  );
}

Widget smallLeaderIndicator(String imgPath, int leaderSchoolNum) {
  return Stack(
    alignment: Alignment.centerLeft,
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 63,
        height: 26,
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
          "$leaderSchoolNum",
          style: CluBTextTheme.bold16.copyWith(
              fontWeight: FontWeight.w800, color: CluBColor.mainColor),
        ),
      ),
      Positioned(
        left: 0,
        child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
                color: CluBColor.gray, shape: BoxShape.circle)),
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
        time.difference(DateTime.now()).toString().split('.')[0],
        style: CluBTextTheme.bold30.copyWith(color: CluBColor.subGreen),
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
                          club.hashTag.length > 3 ? 3 : club.hashTag.length,
                      itemBuilder: (context, index) => Center(
                        child: Text(
                          "#${club.hashTag[index]}",
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
            smallMemberIndicator(club.memberCount, club.maxMemberCount),
            horizontalSpacer(12),
            dateIndicatorGray(
              club.time,
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
          : null,
    ),
  );
}

Widget userProfileInChat(User? user) {
  //TODO USER
  return Row(
    children: [
      userProfileImg(36, 36, img: user!.img),
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
            "${user.major} ${user.schoolNum}",
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
