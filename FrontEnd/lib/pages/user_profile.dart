import 'package:clu_b/components/common_components.dart';
import 'package:clu_b/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfile extends StatefulWidget {
  final int userID;

  const UserProfile({Key? key, required this.userID}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.yellow,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset('assets/img/profile_background.png').image),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 43, left: 26, right: 26),
              child: appBarContent(
                title: "한양대 ERCIA",
                left: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset('assets/svg/arrow_back.svg'),
                ),
              ),
            ),
            verticalSpacer(220),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0)
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.21),
                            offset: const Offset(0, 3),
                            blurRadius: 6)
                      ],
                    ),
                  ),
                  Positioned(
                    top: -100,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.21),
                              offset: const Offset(0, 3),
                              blurRadius: 6)
                        ],
                      ),
                      child: Stack(
                        children: [
                          userProfileImg(147, 147),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
