import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/tab/home/home_club.dart';
import 'package:clu_b/tab/home/home_now.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String currentTab = "now";

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
                    getMyClubLog(false).then((value){
                      print(value.length);
                    });
                    setState(() {
                      currentTab = "now";
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
          Expanded(
            child:
                currentTab == 'now' ? const HomeNowTab() : const HomeCluBTab(),
          )
        ],
      ),
    );
  }
}
