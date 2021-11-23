import 'dart:async';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatefulWidget {
  final String category;
  final String leader;
  final int leaderSchoolNum;
  final bool left;

  final String title;
  final String desc;
  final String img;
  final int memberCount;
  final int maxMemberCount;
  final DateTime time;

  const SmallCard(
      {Key? key,
      required this.category,
      required this.leader,
      required this.leaderSchoolNum,
      required this.title,
      required this.desc,
      required this.img,
      required this.memberCount,
      required this.maxMemberCount,
      required this.time,
      required this.left})
      : super(key: key);

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.64,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      decoration: const BoxDecoration(
        color: CluBColor.black,
        // image: DecorationImage(
        //     image: Image.asset('assets/img/IMG_4624.png').image),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryIndicator('스포츠'),
              verticalSpacer(18),
              Text(
                widget.title,
                style: CluBTextTheme.bold18_28.copyWith(color: Colors.white),
              ),
              Expanded(
                child: Container(),
              ),
              smallMemberIndicator(widget.memberCount, widget.maxMemberCount),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child:
                    smallLeaderIndicator(widget.leader, widget.leaderSchoolNum),
              )
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: dateIndicator(widget.time),
          ),
        ],
      ),
    );
  }
}
