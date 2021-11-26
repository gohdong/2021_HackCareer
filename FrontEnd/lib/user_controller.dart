import 'package:clu_b/data/my_info.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int myID = -1.obs;
  Map<int, MyInfo> users = <int, MyInfo>{}.obs;

  MyInfo? me() {
    return users[myID];
  }

  void setMyID(int id) {
    myID = id;
  }
  String getMyToken(){
    return users[myID]!.token;
  }

  void updateData(MyInfo newUser) {
    users[newUser.id] = newUser;
  }
}
