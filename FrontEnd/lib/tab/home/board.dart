import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/tab/home/board_all.dart';
import 'package:clu_b/tab/home/home_club.dart';
import 'package:clu_b/tab/home/home_now.dart';
import 'package:flutter/material.dart';

class BoardTab extends StatefulWidget {
  const BoardTab({Key? key}) : super(key: key);

  @override
  State<BoardTab> createState() => _BoardTabState();
}

class _BoardTabState extends State<BoardTab> {
  String currentTab = "all";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CluBColor.mainBackground,
      child: Column(
        children: [
          SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      currentTab = "all";
                    });
                  },
                  child: smallTabIndicator(currentTab == "all", "ALL"),
                ),
                horizontalSpacer(10),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentTab = "club";
                    });
                  },
                  child: smallTabIndicator(currentTab == "club", "MY"),
                )
              ],
            ),
          ),
          Expanded(
            child:
            currentTab == 'all' ? const BoardAllTab() : Container(),
          )
        ],
      ),
    );
  }
}
