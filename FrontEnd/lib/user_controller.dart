import 'package:clu_b/data/my_info.dart';
import 'package:clu_b/data/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int myID = -1.obs;
  Map<int, MyInfo> users = <int, MyInfo>{}.obs;

  MyInfo? me() {
    return users[myID];
  }

  User meUser() {
    return User(
      nickName: users[myID]!.nickName,
      id: users[myID]!.id,
      major: users[myID]!.major,
      studentNum: users[myID]!.studentNum,
      imgPath: users[myID]!.imgPath,
      intro: users[myID]!.intro,
      badges: users[myID]!.badges,
      interest: users[myID]!.interest,
      gender: users[myID]!.gender,
      level: users[myID]!.level,
      birth: users[myID]!.birth,
    );
  }

  void setMyID(int id) {
    myID = id;
  }

  String getMyToken() {
    return users[myID]!.token;
  }

  void updateData(MyInfo newUser) {
    users[newUser.id] = newUser;
  }
}
