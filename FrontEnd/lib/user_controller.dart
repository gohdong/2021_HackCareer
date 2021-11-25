import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int myID = -1.obs;

  Map<int, CluBUser> users = <int, CluBUser>{}.obs;

  // Map<String, User> dummyData = {
  //   '1': User(nickName: "페이퍼왕", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
  //   '2': User(nickName: "귀여운돔돌이", major: 'ICT융합학부', schoolNum: 17, img: "assets/img/jiwu.png"),
  //   '3': User(nickName: "고동", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
  // }.obs;

  void setMyID(int id) {
    myID = id;
  }

//
  void updateData(CluBUser newUser) {
    users[newUser.id] = newUser;
  }
}
