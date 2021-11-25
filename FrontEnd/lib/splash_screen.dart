import 'dart:async';

import 'package:clu_b/club_theme.dart';
import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/tab/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _everySecond;

  bool visible = false;

  @override
  void initState() {
    super.initState();

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
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 2000),
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
      ),
    );
  }
}
