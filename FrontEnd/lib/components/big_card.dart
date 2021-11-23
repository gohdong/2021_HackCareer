import 'dart:async';

import 'package:clu_b/club_theme.dart';
import 'package:flutter/material.dart';

class BigCard extends StatefulWidget {
  final String category;
  final String leader;
  final int leaderSchoolNum;

  final String title;
  final String desc;
  final String img;
  final int memberCount;
  final int maxMemberCount;
  final DateTime time;

  const BigCard(
      {Key? key,
      required this.category,
      required this.leader,
      required this.leaderSchoolNum,
      required this.title,
      required this.desc,
      required this.img,
      required this.memberCount,
      required this.maxMemberCount,
      required this.time})
      : super(key: key);

  @override
  State<BigCard> createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 52),
      height: (MediaQuery.of(context).size.width - 52) * 1.43,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: CluBColor.black,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: Image.asset('assets/img/IMG_4624.png').image)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Category
              Container(
                width: 65,
                height: 27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: CluBColor.subGreen,
                    borderRadius: BorderRadius.circular(27)),
                child: Text(
                  widget.category,
                  style: CluBTextTheme.bold18.copyWith(color: Colors.white),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 64.3,
                    height: 26.6,
                    padding: EdgeInsets.only(right: 9),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: CluBColor.darkGray,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "${widget.leaderSchoolNum}",
                      style: CluBTextTheme.bold16.copyWith(
                          fontWeight: FontWeight.w800,
                          color: CluBColor.mainColor),
                    ),
                  ),
                  Positioned(
                    left: -12,
                    child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                            color: CluBColor.gray, shape: BoxShape.circle)),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: CluBTextTheme.bold22_30.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.desc,
              style: CluBTextTheme.semiBold18.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 152,
              child: Column(
                children: [
                  timeIndicator(),
                  Container(
                    width: 83,
                    height: 28,
                    margin: EdgeInsets.only(top: 5.5),
                    decoration: BoxDecoration(
                        color: CluBColor.darkGray,
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.memberCount}",
                          style: CluBTextTheme.extraBold18
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "/",
                          style: CluBTextTheme.extraBold18
                              .copyWith(color: CluBColor.ultraLightGray),
                        ),
                        Text(
                          "${widget.maxMemberCount}",
                          style: CluBTextTheme.extraBold18
                              .copyWith(color: CluBColor.ultraLightGray),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timeIndicator() {
    return Column(
      children: [
        Text(12 <= widget.time.hour && widget.time.hour <= 23 ? "오후" : "오전",
            style: CluBTextTheme.extraBold14.copyWith(color: Colors.white)),
        Text(
            "${12 <= widget.time.hour && widget.time.hour <= 23 ? widget.time.hour - 12 : widget.time.hour}시",
            style: CluBTextTheme.bold30.copyWith(color: Colors.white)),
        SizedBox(
          width: 48,
          child: Divider(
            color: CluBColor.subGreen,
            thickness: 2,
            height: 16,
          ),
        ),
        Text("남은시간",
            style:
                CluBTextTheme.extraBold14.copyWith(color: CluBColor.subGreen)),
        Text(
          "${widget.time.difference(DateTime.now()).toString().split('.')[0]}",
          style: CluBTextTheme.bold30.copyWith(color: CluBColor.subGreen),
        ),
      ],
    );
  }
}
