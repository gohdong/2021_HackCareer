import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallCard extends StatefulWidget {
  final String category;
  final User leader;
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.64,
      decoration: BoxDecoration(
        color: CluBColor.black,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.64,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.cover,
                  image: widget.img != ""
                      ? CachedNetworkImageProvider(
                          widget.img,
                        )
                      : Image.asset(
                          'assets/img/default_img.png',
                        ).image,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.64,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                    image: Image.asset(
                      widget.left
                          ? 'assets/img/small_card_left_mask.png'
                          : 'assets/img/small_card_right_mask.png',
                    ).image)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                categoryIndicator(widget.category),
                verticalSpacer(8),
                Text(
                  widget.title,
                  style: CluBTextTheme.bold18_28.copyWith(color: Colors.white),
                ),
                Expanded(
                  child: Container(),
                ),
                smallMemberIndicator(widget.memberCount, widget.maxMemberCount),
                verticalSpacer(34),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 12),
                  child: leaderIndicatorSummary(widget.leader),
                )
              ],
            ),
          ),
          Positioned(
            right: 26,
            top: 12,
            child: dateIndicator(widget.time),
          ),
        ],
      ),
    );
  }
}
