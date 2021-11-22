import 'dart:io';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum tab {
  board,
  liked,
  home,
  chatting,
  myClub,
}

Map tabDict = {
  tab.board: "학교생활",
  tab.liked: "관심모임",
  tab.home: "홈",
  tab.chatting: "채팅",
  tab.myClub: "내 모임",
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pretendard'),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController test;
  tab currentTab = tab.home;
  List tabs = [tab.board, tab.myClub, tab.home, tab.chatting, tab.liked];

  @override
  void initState() {
    super.initState();
    test = ScrollController(initialScrollOffset: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "한양대 ERICA",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xffC1C1FF)),
        ),
        elevation: 0,
        backgroundColor: CluBColor.mainBackground,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: test,
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                return tabItem(tabs[index]);
              },
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.black, Colors.black.withOpacity(0)])),
        ),
      ),
      body: Container(
        color: CluBColor.mainBackground,
      ),
    );
  }

  Widget tabItem(tab title) {
    return GestureDetector(
      onTap: () {
        int gap = tabs.indexOf(title) - tabs.indexOf(currentTab);
        if (gap > 0) {
          for (int i = 0; i < gap; i++) {
            tabs.add(tabs[0]);
            tabs.removeAt(0);
          }
        }
        if (gap < 0){
          for (int i = 0; i < -gap; i++) {
            tabs.insert(0, tabs.last);
            tabs.removeAt(tabs.length-1);
          }
        }


        test.jumpTo(40);
        setState(() {
          currentTab = title;
        });
      },
      child: title == tab.home
          ? SizedBox(
              width: 100,
              child: Center(
                  child: SvgPicture.asset(
                currentTab == title
                    ? 'assets/svg/luby_colored.svg'
                    : 'assets/svg/luby_gray.svg',
                width: 37,
                height: 32,
              )),
            )
          : Container(
              width: 100,
              alignment: Alignment.center,
              child: Text(
                tabDict[title],
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: currentTab == title
                        ? CluBColor.mainColor
                        : CluBColor.lightGray),
              ),
            ),
    );
  }
}
