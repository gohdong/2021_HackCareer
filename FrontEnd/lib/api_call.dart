import 'dart:convert';

import 'package:clu_b/data/club.dart';
import 'package:clu_b/data/club2.dart';
import 'package:clu_b/data/feed.dart';
import 'package:clu_b/user_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

import 'data/user.dart';

const String url = 'http://www.funani.tk:3000';

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

Future<List<Feed>> getFeeds({take = 20, skip = 0, category = ''}) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Feed> feeds = [];
  await http.get(
    Uri.parse(url +
        '/feed?take=${take.toString()}&skip=${skip.toString()}&category=$category'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    try {
      List<dynamic> resJson = jsonDecode(res.body);
      for (Map i in resJson) {
        feeds.add(Feed.fromJson(i));
      }
    } catch (e) {
      // feed Not found;
    }
  });
  return feeds;
}

// http://www.funani.tk:3000/club?take=20&skip=0&isNow=false&category=영화
Future<List<Club2>> getClubs({take=20,skip=0,category='',isNow=false}) async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club2> clubs = [];
  await http.get(
      Uri.parse(url+'/club?take=${take.toString()}&skip=${skip.toString()}&category=$category&isNow=$isNow'),
      headers: {"Authorization": 'Bearer $token'},).then((res){
        try{
          List<dynamic> resJson = jsonDecode(res.body);
          for (Map i in resJson) {
            clubs.add(Club2.fromJson(i));
          }
        }catch(e){
          clubs = [];
        }
  });
  return clubs;
}

Future<List<User>> getClubMembers(clubId)async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<User> members = [];
  await http.get(
    Uri.parse(url+'/member/${clubId.toString()}'),
    headers: {"Authorization": 'Bearer $token'},).then((res){

      List resJson = jsonDecode(res.body);
      for (Map i in resJson) {
        members.add(User.fromJson(i['__user__']));
      }
  });
  return members;
}

// http://www.funani.tk:3000/user/my/likeClubs
Future<List<Club2>> getMyLikeClubs(isNow)async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club2> likeClubs = [];
  await http.get(
    Uri.parse(url+'/user/my/likeClubs?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},).then((res){
    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      likeClubs.add(Club2.fromJson(i['__club__']));
    }
  });
  return likeClubs;
}

Future<List<Club2>> getMyClubLog(bool isNow)async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club2> deadClubs = [];
  await http.get(
    Uri.parse(url+'/member/myClubLog?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},).then((res){

    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      deadClubs.add(Club2.fromJson(i['__club__']));
    }
  });
  return deadClubs;
}

Future<List<Club2>> getMyLiveClubs(bool isNow)async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club2> liveClubs = [];
  await http.get(
    Uri.parse(url+'/member/myLiveClub?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},).then((res){

    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      liveClubs.add(Club2.fromJson(i['__club__']));
    }
  });
  return liveClubs;
}



