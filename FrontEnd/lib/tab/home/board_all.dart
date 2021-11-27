import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/big_card.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/components/common_method.dart';
import 'package:clu_b/components/small_card.dart';
import 'package:clu_b/data/feed.dart';
import 'package:clu_b/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:swipable_stack/swipable_stack.dart';

class BoardAllTab extends StatefulWidget {
  const BoardAllTab({Key? key}) : super(key: key);

  @override
  State<BoardAllTab> createState() => _BoardAllTabState();
}

class _BoardAllTabState extends State<BoardAllTab> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  Map category = {
    'all': '전체',
    'hot': 'HOT',
    'ask': '질문',
    'information': '정보',
    'promotion': '홍보',
    'review': '후기',
    'good_food': '맛집',
  };

  String currentCategory = 'all';

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
      backgroundColor: CluBColor.mainBackground,
      floatingActionButton: InkWell(
        onTap: () {
          customDialog(
              context: context,
              title: "테스트",
              content: "내용",
              confirm: "예",
              cancel: "아니오");
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 68,
          width: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: CluBColor.black,
              shape: BoxShape.circle,
              border: Border.all(color: CluBColor.mainColor, width: 1.5)),
          child: Image.asset('assets/img/floatbutton.png'),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: CluBColor.mainBackground,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26, top: 22, bottom: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "우리들끼리 소통공간",
                      style:
                          CluBTextTheme.medium18.copyWith(color: Colors.white),
                    ),
                    verticalSpacer(8),
                    Text(
                      "오늘도 일상을 즐기세요!",
                      style: CluBTextTheme.extraBold18
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                height: 46,
                margin: const EdgeInsets.only(left: 26, right: 26, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: _formKey,
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 5, bottom: 5),
                            hintText: "지금 오버워치 한판 어때요?",
                            hintStyle: CluBTextTheme.medium18.copyWith(
                                fontWeight: FontWeight.w600,
                                color: CluBColor.ultraLightGray),
                            focusColor: null,
                            hoverColor: null,
                            fillColor: null,
                            isDense: true,
                            border: InputBorder.none),
                        maxLines: 1,
                        minLines: 1,
                        cursorColor: CluBColor.mainColor,
                        style: CluBTextTheme.medium18
                            .copyWith(color: CluBColor.black),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
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
                  padding: const EdgeInsets.only(left: 26, bottom: 5),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
                content: FutureBuilder<List>(
                    future: currentCategory == 'hot'
                        ? getHotFeed(query: _textEditingController.text)
                        : getFeedsBySearch(
                            category: currentCategory != "all"
                                ? category[currentCategory]
                                : "",
                            query: _textEditingController.text),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Feed tempFeed = snapshot.data![index];
                          return Container(
                            height: 176,
                            padding: const EdgeInsets.only(
                              left: 26,
                              right: 26,
                              top: 22,
                              bottom: 8,
                            ),
                            color: CluBColor.black,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    feedCategoryIndicator(tempFeed.category),
                                    Text(
                                      timeFromNow(tempFeed.createdAt),
                                      style: CluBTextTheme.semiBold14_20
                                          .copyWith(
                                              height: 1,
                                              color: CluBColor.ultraLightGray),
                                    )
                                  ],
                                ),
                                verticalSpacer(8),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    tempFeed.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: CluBTextTheme.semiBold14_20.copyWith(
                                      color: const Color(0xffdbdbdb),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container()),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/like_count.svg'),
                                        Container(
                                          width: 20,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${tempFeed.likeCount}",
                                            style: CluBTextTheme.semiBold14_20
                                                .copyWith(
                                              color: CluBColor.ultraLightGray,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            'assets/svg/comment_count.svg'),
                                        Text(
                                          "${tempFeed.commentCount}",
                                          style: CluBTextTheme.semiBold14_20
                                              .copyWith(
                                            color: CluBColor.ultraLightGray,
                                            height: 1.1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${tempFeed.writer.nickName} · ${tempFeed.writer.major} ${extractYearOnStudentNumber(tempFeed.writer.studentNum)}",
                                      style: CluBTextTheme.semiBold14_20
                                          .copyWith(
                                              height: 1,
                                              color: CluBColor.lightGray),
                                    )
                                  ],
                                )
                              ],
                            ),
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
      ),
    );
  }
}
