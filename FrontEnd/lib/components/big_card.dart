import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/data/user.dart';
import 'package:flutter/material.dart';

class BigCard extends StatefulWidget {
  final String category;
  final User leader;

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
      if (mounted) {
        setState(() {});
      }
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
      decoration: BoxDecoration(
        color: CluBColor.mainColor,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          fit: widget.img != "" ? BoxFit.fitHeight : BoxFit.fill,
          image: widget.img != ""
              ? CachedNetworkImageProvider(widget.img)
              : Image.asset(
                  'assets/img/default_img.png',
                ).image,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/img/big_card_mask.png',
                ).image,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category
                    categoryIndicator(widget.category),
                    leaderIndicatorSummary(widget.leader)
                  ],
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style:
                        CluBTextTheme.bold22_30.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.desc,
                    style:
                        CluBTextTheme.semiBold18.copyWith(color: Colors.white),
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
                        memberIndicator(
                            widget.memberCount, widget.maxMemberCount)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
