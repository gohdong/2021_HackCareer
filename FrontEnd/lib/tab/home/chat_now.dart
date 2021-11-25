import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/pages/club_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

class ChatNowTab extends StatefulWidget {
  const ChatNowTab({Key? key}) : super(key: key);

  @override
  State<ChatNowTab> createState() => _ChatNowTabState();
}

class _ChatNowTabState extends State<ChatNowTab> {
  final ClubController c = Get.find();

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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: CluBColor.mainBackground,
        child: newDeck(),
      ),
    );
  }

  Widget newDeck() {
    return ListView.separated(
      itemCount: c.dummyData.length,
      itemBuilder: (context, index) {
        String key = c.dummyData.keys.elementAt(index);
        return clubInfo(c.dummyData[key]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
