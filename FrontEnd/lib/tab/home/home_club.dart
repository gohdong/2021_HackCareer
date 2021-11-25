import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/components/small_card.dart';
import 'package:clu_b/data/club2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:swipable_stack/swipable_stack.dart';

class HomeCluBTab extends StatefulWidget {
  const HomeCluBTab({Key? key}) : super(key: key);

  @override
  State<HomeCluBTab> createState() => _HomeCluBTabState();
}

class _HomeCluBTabState extends State<HomeCluBTab> {
  Map category = {
    'all': '전체',
    'game': '게임',
    'drink': '술',
    'study': '스터디',
    'movie': '영화',
    'reading': '독서',
    'good_food': '맛집탐방',
    'sport': '스포츠',
    'display' : '전시'
  };

  String currentCategory = 'all';
  List data = [
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n2',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n3',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n4',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n5',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n6',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n7',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n8',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n9',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n10',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
  ].obs;

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
      floatingActionButton: InkWell(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 68,
          width: 68,
          alignment: Alignment.center,
          child: Image.asset('assets/img/floatbutton.png'),
        ),
      ),
      body: Container(
        color: CluBColor.mainBackground,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 22,bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "안녕하세요, 크루님",
                    style: CluBTextTheme.medium18.copyWith(color: Colors.white),
                  ),
                  Text(
                    "오늘도 일상을 즐기세요!",
                    style:
                        CluBTextTheme.extraBold18.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              height: 46,
              margin: const EdgeInsets.only(left: 26,right: 26, bottom: 14),
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "지금 오버워치 한판 어때요?",
                      style: CluBTextTheme.medium18
                          .copyWith(color: CluBColor.ultraLightGray),
                    ),
                  ),
                  SvgPicture.asset('assets/svg/search.svg')
                ],
              ),
            ),
            StickyHeader(
              header: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: CluBColor.mainBackground,
                padding: const EdgeInsets.only(left: 26),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    String key = category.keys.elementAt(index);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentCategory = key;
                            });
                          },
                          child: Text(
                            "${category[key]}",
                            style: CluBTextTheme.semiBold18.copyWith(
                                color: currentCategory == key
                                    ? CluBColor.mainColor
                                    : CluBColor.gray),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              content: FutureBuilder<List<Club2>>(
                  future: getClubs(
                    category: currentCategory != "all"
                        ? category[currentCategory]
                        : "",
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpacer(40),
                            SvgPicture.asset(
                              'assets/svg/luby_gray.svg',
                              width: 100,
                            ),
                            verticalSpacer(
                              20,
                            ),
                            Text(
                              "지금은 모임이 없어요!",
                              style: CluBTextTheme.medium18
                                  .copyWith(color: CluBColor.lightGray),
                            ),
                            verticalSpacer(
                              100,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SmallCard(
                          left: index % 2 == 1,
                          title: snapshot.data![index].title,
                          category: snapshot.data![index].category,
                          desc: snapshot.data![index].description,
                          img: snapshot.data![index].imagePath,
                          leader: snapshot.data![index].leader,
                          maxMemberCount: snapshot.data![index].numLimit,
                          memberCount: snapshot.data![index].memberCount,
                          time: snapshot.data![index].timeLimit,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          verticalSpacer(6),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
