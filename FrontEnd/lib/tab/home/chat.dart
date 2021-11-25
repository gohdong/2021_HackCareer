import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/tab/home/home_club.dart';
import 'package:clu_b/tab/home/home_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChattingTab extends StatefulWidget {
  const ChattingTab({Key? key}) : super(key: key);

  @override
  State<ChattingTab> createState() => _ChattingTabState();
}

class _ChattingTabState extends State<ChattingTab> {
  String currentTab = "now";
  ClubController clubController = Get.find();

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

                      currentTab = "now";
                      getFeeds(category: 1, skip: 2,take:10);
                    });
                  },
                  child: smallTabIndicator(currentTab == "now", "NOW"),
                ),
                horizontalSpacer(10),
                InkWell(
                  onTap: () {
                    setState(() {
                      currentTab = "club";
                    });
                  },
                  child: smallTabIndicator(currentTab == "club", "크루비"),
                )
              ],
            ),
          ),
          Expanded(child: chatBody(currentTab == "now"))
        ],
      ),
    );
  }

  Widget chatBody(bool isNow) {
    return Container(
      padding: const EdgeInsets.only(top: 22, left: 26, right: 26, bottom: 20),
      child: ListView.separated(
        itemCount: clubController.dummyData.length,
        itemBuilder: (context, index) {
          String key = clubController.dummyData.keys.elementAt(index);
          return clubInfo(clubController.dummyData[key]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 20,
            color: CluBColor.darkGray,
            thickness: 2,
          );
        },
      ),
    );
  }
}
