import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/get_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClubPage extends StatefulWidget {
  final String clubID;

  const ClubPage({Key? key, this.clubID = '1'}) : super(key: key);

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final ReactiveController clubController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: CluBColor.mainBackground,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  height: 352,
                  color: Colors.yellow,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 26, right: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clubInfo(clubController.dummyData[widget.clubID],
                          eclipseTitle: false),
                      verticalSpacer(30),
                      //TODO USER INDICATOR
                      Row(
                        children: [
                          userProfileImg(48, 48, img: 'assets/img/jiwu.png'),
                          horizontalSpacer(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "귀여운곰돌이",
                                style: CluBTextTheme.bold16,
                              ),
                              Text(
                                "ICT융합학부 17",
                                style: CluBTextTheme.semiBold14_20
                                    .copyWith(color: CluBColor.mainColor),
                              )
                            ],
                          )
                        ],
                      ),
                      verticalSpacer(20),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: CluBColor.darkGray,
                      ),
                      verticalSpacer(12),
                      Text(
                        clubController.dummyData[widget.clubID]!.desc,
                        style: CluBTextTheme.semiBold16_26,
                      ),
                      verticalSpacer(50),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: CluBColor.darkGray,
                      ),
                      verticalSpacer(8),
                      Text(
                        "참여자",
                        style: CluBTextTheme.bold16
                            .copyWith(color: CluBColor.darkGray),
                      ),
                      verticalSpacer(8),
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Align(
                              widthFactor: 0.75,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        offset: const Offset(0, 3),
                                        blurRadius: 6)
                                  ],
                                ),
                                child: userProfileImg(36, 36),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
