import 'package:clu_b/data/club.dart';
import 'package:get/get.dart';

class ClubController extends GetxController {
  List test = [1, 2, 3].obs;

  List data = [
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n1',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n2',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n3',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n4',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n5',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n6',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n7',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n8',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n9',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
    {
      'category': '전시',
      'leader': 'aa',
      'leaderSchoolNum': 17,
      'title': '4시에 요시고 사진전보러\n10',
      'desc': '엣헴 선배랑 같이 보러가자',
      'img': 'assets/img/IMG_4624.png',
      'memberCount': 2,
      'maxMemberCount': 4,
      'time': DateTime.now().add(Duration(hours: 4))
    },
  ].obs;

  Map<dynamic, Club> dummyData = {
    '1': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러가실분 긴 텍스트를 넣어용',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      hashTag : ["전시회","전시회"],
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '2': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n2',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '3': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n3',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '4': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n4',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '5': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n5',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '6': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n6',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '7': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n7',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '8': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n8',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '9': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n9',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
    '10': Club(
      category: '전시',
      leader: 'aa',
      leaderSchoolNum: 17,
      title: '4시에 요시고 사진전보러\n10',
      desc: '엣헴 선배랑 같이 보러가자',
      imgPath: 'assets/img/IMG_4624.png',
      memberCount: 2,
      maxMemberCount: 4,
      time: DateTime.now().add(
        const Duration(hours: 4),
      ),
    ),
  }.obs;

  void newData(Map<dynamic, Club> newData) {
    dummyData.addAll(newData);
  }
}
