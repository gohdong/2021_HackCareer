import 'dart:convert';

import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/feed.dart';
import 'package:clu_b/user_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

const String url = 'http://www.funani.tk:3000';

Future<Map<int, Club>> getNowClub() async {
  // http.get(url)
  return <int,Club>{};
}

Future<List> getFeeds({take=20,skip=0,category=''}) async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  return http.get(
    Uri.parse(url+'/feed?take=${take.toString()}&skip=${skip.toString()}&category=$category'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    try {
      List<dynamic> resJson = jsonDecode(res.body);
      List<Feed> feeds = [];
      for (Map i in resJson) {
        feeds.add(Feed.fromJson(i));
      }
      return feeds;
    } catch (e) {
      // feed Not found;
      return [];
    }


  });
}

