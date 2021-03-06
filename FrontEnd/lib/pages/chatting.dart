import 'package:clu_b/api_call.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/club_controller.dart';
import 'package:clu_b/data/chat.dart';
import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/user.dart';
import 'package:clu_b/main.dart';
import 'package:clu_b/pages/club_page.dart';
import 'package:clu_b/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChattingRoom extends StatefulWidget {
  final Club club;

  const ChattingRoom({Key? key, required this.club}) : super(key: key);

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

  Map<int, User> chatMembers = {};

  List<Chat> chatLog = [];

  IO.Socket socket = IO.io('ws://www.funani.tk:4000/chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  @override
  void initState() {
    super.initState();
    enterChattingRoom();
    // channel.stream.listen((message) {
    //   channel.sink.add('received!');
    //   channel.sink.close(status.goingAway);
    // });

    me = userController.myID;
  }

  @override
  void dispose() {
    super.dispose();
    socket.disconnect();
    _scrollController.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CluBColor.mainBackground,
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
                      title: "??????",
                    ),
                    verticalSpacer(10),
                    InkWell(
                        onTap: () {
                          Get.to(() => ClubPage(club: widget.club));
                        },
                        child: clubInfo(widget.club)),
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
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  controller: _scrollController,
                  itemCount: chatLog.length,
                  itemBuilder: (context, index) {
                    if (chatLog[index].sender.id == me) {
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
                                    chatLog[index].sender.id !=
                                        chatLog[index + 1].sender.id
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
                                  chatLog[index].sender.id !=
                                      chatLog[index - 1].sender.id
                              ? userProfileInChat(chatLog[index].sender)
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
                                  chatLog[index].sender.id !=
                                      chatLog[index + 1].sender.id
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
                    left: 26, right: 26, top: 10, bottom: 10),
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
                                      hintText: "???????????? ???????????????.",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      socket.emit('chatToServer', {
        'room': widget.club.id,
        'sender': me,
        'content': _textEditingController.text
      });
      // setState(() {
      // chatLog.add(Chat(
      //     contents: _textEditingController.text,
      //     sendAt: DateTime.now(),
      //     sender: userController.me()));
      // });
      _textEditingController.clear();
    }
  }

  Future<void> enterChattingRoom() async {
    await getClubMembers(widget.club.id).then((value) {
      for (var element in value) {
        chatMembers[element.id] = element;
      }
    });
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('joinRoom', widget.club.id);
    });

    socket.on('joinedRoom', (data) async {
      if (chatLog.isEmpty) {
        await data.forEach((element) {
          User? tempSender = chatMembers[element['sender']['id']];
          chatLog.add(
            Chat(
                sendAt: DateTime.parse(element['createdAt']),
                contents: element['content'],
                sender: tempSender!),
          );
        });
        setState(() {});
        Future.delayed(const Duration(milliseconds: 500), () {}).then((value) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
      }
    });

    socket.on('chatToClient', (data) {
      User? tempSender = chatMembers[data['sender']['id']];
      chatLog.add(
        Chat(
            sendAt: DateTime.parse(data['createdAt']),
            contents: data['content'],
            sender: tempSender!),
      );
      setState(() {});
      Future.delayed(const Duration(milliseconds: 100), () {}).then((value) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });

    socket.onDisconnect((_) => print('disconnect'));
  }
}
