import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/my_info.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int myID = -1.obs;
  Map<int, MyInfo> users = <int, MyInfo>{}.obs;

  // Map<String, User> dummyData = {
  //   '1': User(nickName: "페이퍼왕", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
  //   '2': User(nickName: "귀여운돔돌이", major: 'ICT융합학부', schoolNum: 17, img: "assets/img/jiwu.png"),
  //   '3': User(nickName: "고동", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
  // }.obs;

  MyInfo? me() {
    return users[myID];
  }

  void setMyID(int id) {
    myID = id;
  }
  String getMyToken(){
    return users[myID]!.token;
  }

//
  void updateData(MyInfo newUser) {
    users[newUser.id] = newUser;
  }
}
