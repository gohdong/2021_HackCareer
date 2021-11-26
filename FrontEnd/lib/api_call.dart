import 'dart:convert';

import 'package:clu_b/data/club.dart';
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
Future<List<Club>> getClubs(
    {take = 20, skip = 0, category = '', isNow = false}) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club> clubs = [];
  await http.get(
    Uri.parse(url +
        '/club?take=${take.toString()}&skip=${skip.toString()}&category=$category&isNow=$isNow'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    try {
      List<dynamic> resJson = jsonDecode(res.body);
      for (Map i in resJson) {
        clubs.add(Club.fromJson(i));
      }
    } catch (e) {
      clubs = [];
    }
  });
  return clubs;
}

Future<List<User>> getClubMembers(clubId) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<User> members = [];
  await http.get(
    Uri.parse(url + '/member/${clubId.toString()}'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      members.add(User.fromJson(i['__user__']));
    }
  });
  return members;
}

// http://www.funani.tk:3000/user/my/likeClubs
Future<List<Club>> getMyLikeClubs(isNow) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club> likeClubs = [];
  await http.get(
    Uri.parse(url + '/user/my/likeClubs?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      likeClubs.add(Club.fromJson(i['__club__']));
    }
  });
  return likeClubs;
}

Future<List<Club>> getMyClubLog(bool isNow) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club> deadClubs = [];
  await http.get(
    Uri.parse(url + '/member/myClubLog?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      deadClubs.add(Club.fromJson(i['__club__']));
    }
  });
  return deadClubs;
}

Future<List<Club>> getMyLiveClubs(bool isNow) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club> liveClubs = [];
  await http.get(
    Uri.parse(url + '/member/myLiveClub?isNow=${isNow.toString()}'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    List resJson = jsonDecode(res.body);
    for (Map i in resJson) {
      liveClubs.add(Club.fromJson(i['__club__']));
    }
  });
  return liveClubs;
}

Future<bool> joinClub(int clubID) async {
  print("==POST JOIN CLUB==");
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  bool result = false;
  await http.post(
    Uri.parse(url + '/club/$clubID/member'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    print(res.statusCode);
    print(res.body);
    result = res.statusCode == 201;
  });
  print("==END JOIN CLUB==");
  return result;
}

Future<bool> leaveClub(int clubID) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  bool result = false;
  await http.delete(
    Uri.parse(url + '/club/$clubID/member'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    result = res.statusCode == 200;
  });
  return result;
}

Future<bool> likeClub(int clubID) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  bool result = false;
  await http.post(
    Uri.parse(url + '/club/$clubID/like'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    result = res.statusCode == 201;
  });
  return result;
}


// http://www.funani.tk:3000/club/:clubId/unlike
Future<bool> unlikeClub(int clubID) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  bool result = false;
  await http.post(
    Uri.parse(url + '/club/$clubID/unlike'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    result = res.statusCode == 201;
  });
  return result;
}

Future<List<Feed>> getFeedsBySearch({take = 20, skip = 0,category = '',query = ''}) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Feed> feeds = [];
  // http://www.funani.tk:3000/feed/search?take=20&skip=0&keyword=t
  await http.get(
    Uri.parse(url +
        '/feed/search?take=$take&skip=$skip&keyword=$query&category=$category'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    print(jsonDecode(res.body));
    print(jsonDecode(res.body).length);
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

Future<List<Club>> getClubsBySearch(
    {take = 20, skip = 0, category = '', isNow = false , query = ""}) async {
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  List<Club> clubs = [];
  await http.get(
    Uri.parse(url +
        '/club/search?take=${take.toString()}&skip=${skip.toString()}&category=$category&isNow=$isNow&keyword=$query'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    try {
      List<dynamic> resJson = jsonDecode(res.body);
      for (Map i in resJson) {
        clubs.add(Club.fromJson(i));
      }
    } catch (e) {
      clubs = [];
    }
  });
  return clubs;
}

// www.funani.tk:3000/user/:id/profile
Future<User?> getMember(int memberID) async{
  final UserController userController = Get.find();
  String token = userController.getMyToken();
  User? result ;
  await http.get(
    Uri.parse(url + '/user/$memberID/profile'),
    headers: {"Authorization": 'Bearer $token'},
  ).then((res) {
    if(res.statusCode == 200){
      result = User.fromJson(jsonDecode(res.body));
      print(result);
    }
  });
  return result;
}