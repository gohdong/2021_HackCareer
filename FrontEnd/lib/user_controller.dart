import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString myID = '3'.obs;
  Map<String, User> dummyData = {
    '1': User(nickName: "페이퍼왕", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
    '2': User(nickName: "귀여운돔돌이", major: 'ICT융합학부', schoolNum: 17, img: "assets/img/jiwu.png"),
    '3': User(nickName: "고동", major: '소프트웨어학부', schoolNum: 16, img: "assets/img/default_profile.png"),
  }.obs;

  void setMyID(id) {
    myID = id;
  }

  void newData(Map<String, User> newData) {
    dummyData.addAll(newData);
  }
}
