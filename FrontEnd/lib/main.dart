import 'dart:io';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/appbar.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/tab/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
    return GetMaterialApp(
      title: 'CluB',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Pretendard'),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 428,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(428, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
    print(MediaQuery.of(context).padding);
    return Scaffold(
      primary: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Stack(
          children: [
            Container(
              color: CluBColor.mainBackground,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 47),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.black, Colors.black.withOpacity(0)]),
              ),
              child: Column(
                children: [
                  const Text(
                    "한양대 ERICA",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xffC1C1FF)),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                    height: 40,
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
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
        color: CluBColor.mainBackground,
        child: tabBody(),
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
        if (gap < 0) {
          for (int i = 0; i < -gap; i++) {
            tabs.insert(0, tabs.last);
            tabs.removeAt(tabs.length - 1);
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
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: currentTab == title
                        ? CluBColor.mainColor
                        : CluBColor.lightGray),
              ),
            ),
    );
  }

  Widget tabBody() {
    if (currentTab == tab.home) {
      return Home();
    }
    return Container();
  }
}
