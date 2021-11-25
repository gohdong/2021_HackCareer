import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int myID = -1.obs;
  Map<int, CluBUser> users = <int, CluBUser>{}.obs;

  CluBUser? me() {
    return users[myID];
  }

  void setMyID(int id) {
    myID = id;
  }

//
  void updateData(CluBUser newUser) {
    users[newUser.id] = newUser;
  }
}
