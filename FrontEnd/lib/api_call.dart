import 'dart:convert';

import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/feed.dart';
import 'package:clu_b/user_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

Future<Map<int, Club>> getNowClub() async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();

  http.get(
    Uri.parse('http://www.funani.tk:3000/club?take=20&isNow=true'),
    headers: {"Authorization": 'Bearer $token'},
  ).then(
    (res) {
      List<dynamic> resJson = jsonDecode(res.body);
      print(resJson[0].keys.forEach((element) {
        print("$element ${resJson[0][element]}");
      }));
    },
  );

  return <int, Club>{};
}

Future<dynamic> getFeeds(take, skip) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  return http.get(
    Uri.parse('http://www.funani.tk:3000/feed?take=20'),
    headers: {"Authorization": 'Bearer $token'},
  ).then(
    (res) {
      List<dynamic> resJson = jsonDecode(res.body);
      List<Feed> feeds = [];
      for (Map i in resJson) {
        feeds.add(Feed.fromJson(i));
      }
    },
  );
}
