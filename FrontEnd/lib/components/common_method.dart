import 'package:clu_b/club_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String weekDayToString(int dateNum) {
  if (dateNum == 1) {
    return "월요일";
  }
  if (dateNum == 2) {
    return "화요일";
  }
  if (dateNum == 3) {
    return "수요일";
  }
  if (dateNum == 4) {
    return "목요일";
  }
  if (dateNum == 5) {
    return "금요일";
  }
  if (dateNum == 6) {
    return "토요일";
  }

  return "일요일";
}

String extractYearOnStudentNumber(int studentNum) {
  return studentNum.toString().substring(2, 4);
}

String convertInterestToHashTag(List interest) {
  String temp = "";

  interest.forEach((element) {
    temp += "#$element ";
  });

  return temp;
}

String timeFromNow(DateTime date) {
  DateTime now = DateTime.now();
  if (now.difference(date).inMinutes <= 60) {
    return "${now.difference(date).inMinutes}분 전";
  } else if (now.difference(date).inHours <= 24) {
    return "${now.difference(date).inHours}시간 전";
  }
  return date.toString().split(' ')[0].replaceAll('-', '.');
}

void customDialog({required String title}) {
  Get.defaultDialog(
    backgroundColor: Color(0xff272727),
    title: "ad",
    titleStyle: CluBTextTheme.bold22_30,
    confirm: Text("예"),
    cancel: Text("아니요"),
    content: Text("ㅁㄴㅇㅇ"),
    contentPadding: EdgeInsets.all(30),
  );
}
