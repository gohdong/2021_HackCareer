import 'dart:async';
import 'dart:convert';

import 'package:clu_b/club_controller.dart';
import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/data/user.dart';
import 'package:clu_b/tab/home/home.dart';
import 'package:clu_b/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.find();

  // final UserController userController = Get.find();
  late Timer _everySecond;

  bool visible = false;

  @override
  void initState() {
    super.initState();
    signIn();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      timer.cancel();
      visible = true;
    });
    _everySecond = Timer.periodic(
      const Duration(milliseconds: 2000),
      (Timer t) {
        _everySecond.cancel();
        Get.offNamed('/home');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _everySecond.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: CluBColor.mainBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/luby_colored.svg',
              width: 110,
            ),
            verticalSpacer(22),
            SvgPicture.asset(
              'assets/svg/logo.svg',
              width: 85,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: "test@test.com", password: "qwer1234")
        .then(
      (UserCredential value) {
        value.user!.getIdToken().then((token) {
          http.get(
            Uri.parse('http://www.funani.tk:3000/user/my'),
            headers: {"Authorization": 'Bearer $token'},
          ).then(
            (res) {
              Map resJson = jsonDecode(res.body);
              userController.updateData(
                CluBUser(
                    nickName: resJson['nickname'],
                    id: int.parse(resJson['id'].toString()),
                    major: resJson['department'],
                    studentNum: int.parse(resJson['studentNum'].toString()),
                    imgPath: resJson['imgPath'],
                    intro: resJson['intro'],
                    badges: resJson['badges'],
                    interest: resJson['interest'],
                    gender: resJson['gender'],
                    level: int.parse(resJson['level'].toString()),
                    birth: DateTime.parse(resJson['birth']),
                    joinedClubs: resJson['__joinedClubs__'],
                    createdClubs: resJson['__createdClubs__']),
              );

              print(userController.users);
              userController.setMyID(resJson['id'].toInt());
            },
          );
        });
      },
    );
  }
}