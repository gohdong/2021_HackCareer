import 'dart:async';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
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
              categoryIndicator(widget.category),
              leaderIndicator(widget.leader,widget.leaderSchoolNum)
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
                  timeIndicator(widget.time),
                  memberIndicator(widget.memberCount, widget.maxMemberCount)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
