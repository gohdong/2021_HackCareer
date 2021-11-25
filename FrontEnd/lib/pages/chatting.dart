import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/data/chat.dart';
import 'package:clu_b/main.dart';
import 'package:clu_b/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChattingRoom extends StatefulWidget {
  final String clubID;

  const ChattingRoom({Key? key, required this.clubID}) : super(key: key);

  @override
  State<ChattingRoom> createState() => _ChattingRoomState();
}

class _ChattingRoomState extends State<ChattingRoom> {
  final ClubController clubController = Get.find();
  final UserController userController = Get.find();
  final ScrollController _scrollController = ScrollController();
  late int me;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textEditingController = TextEditingController();

  List<Chat> chatLog = [
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 10)),
        contents: "안녕하세용?",
        senderID: 2),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 9)),
        contents: "안녕하세요. 고학번도 참여되나요?",
        senderID: 1),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 8)),
        contents: "안녕하세용~ 혹시 시간조정 가능한가요 긴텍스트트트트ㅏㅇㄴ러ㅗ미ㅓㅏㅗㄴㅇㄹ ?",
        senderID: 3),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 7)),
        contents: "네넵~전가능해요.?",
        senderID: 2),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 6)),
        contents: "30분만 늦출수있을까용??",
        senderID: 3),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 5)),
        contents: "좋아요",
        senderID: 1),
    Chat(
        sendAt: DateTime.now().subtract(const Duration(minutes: 4)),
        contents: "3시 30분으로 하죱?",
        senderID: 1),
  ];

  @override
  void initState() {
    super.initState();
    me = userController.myID;
  }

  @override
  Widget build(BuildContext context) {
    print(me);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: CluBColor.mainBackground,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 43, left: 26, right: 26),
                decoration: BoxDecoration(
                  color: CluBColor.black,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Colors.black, Colors.black.withOpacity(0)],
                  ),
                ),
                child: Column(
                  children: [
                    appBarContent(
                      left: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset('assets/svg/arrow_back.svg'),
                      ),
                      right: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('assets/svg/hamburger.svg'),
                      ),
                      title: "채팅",
                    ),
                    verticalSpacer(10),
                    clubInfo(clubController.dummyData[widget.clubID]),
                    const Divider(
                      height: 16,
                      thickness: 2,
                      color: CluBColor.darkGray,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  controller: _scrollController,
                  itemCount: chatLog.length,
                  itemBuilder: (context, index) {
                    if (chatLog[index].senderID == me) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Container(
                              // width: 100,
                              margin: const EdgeInsets.only(left: 90),
                              padding: const EdgeInsets.only(
                                  left: 20, top: 4, bottom: 8, right: 14),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              child: Text(
                                chatLog[index].contents,
                                style: CluBTextTheme.semiBold16_26
                                    .copyWith(color: CluBColor.black),
                              ),
                            ),
                            index + 1 < chatLog.length &&
                                    chatLog[index].senderID !=
                                        chatLog[index + 1].senderID
                                ? verticalSpacer(20)
                                : verticalSpacer(6),
                          ],
                        ),
                      );
                    }

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0 ||
                                  chatLog[index].senderID !=
                                      chatLog[index - 1].senderID
                              ? userProfileInChat(userController
                                  .dummyData[chatLog[index].senderID])
                              : Container(),
                          verticalSpacer(6),
                          Container(
                            // width: 100,
                            margin: const EdgeInsets.only(left: 36, right: 90),
                            padding: const EdgeInsets.only(
                                left: 14, top: 4, bottom: 8, right: 20),
                            decoration: const BoxDecoration(
                              color: CluBColor.mainColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Text(
                              chatLog[index].contents,
                              style: CluBTextTheme.semiBold16_26
                                  .copyWith(color: CluBColor.black),
                            ),
                          ),
                          index + 1 < chatLog.length &&
                                  chatLog[index].senderID !=
                                      chatLog[index + 1].senderID
                              ? verticalSpacer(20)
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 26, right: 26, top: 10, bottom: 40),
                color: CluBColor.black,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/append.svg'),
                      horizontalSpacer(10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: CluBColor.mainColor.withOpacity(0.11),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  key: _formKey,
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 13, top: 5, bottom: 5),
                                      hintText: "메시지를 입력하세요.",
                                      hintStyle: CluBTextTheme.medium12
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: CluBColor.darkGray),
                                      focusColor: null,
                                      hoverColor: null,
                                      fillColor: null,
                                      isDense: true,
                                      border: InputBorder.none),
                                  maxLines: 5,
                                  minLines: 1,
                                  cursorColor: CluBColor.mainColor,
                                  style: CluBTextTheme.medium12,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  sendMessage();
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  margin: const EdgeInsets.only(
                                      right: 5, bottom: 4, top: 4),
                                  decoration: const BoxDecoration(
                                      color: CluBColor.mainColor,
                                      shape: BoxShape.circle),
                                  child:
                                      SvgPicture.asset('assets/svg/send.svg'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        chatLog.add(Chat(
            contents: _textEditingController.text,
            sendAt: DateTime.now(),
            senderID: me));
      });
      _textEditingController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {}).then((value) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }
}
