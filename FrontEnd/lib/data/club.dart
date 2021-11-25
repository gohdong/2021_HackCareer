import 'package:clu_b/data/user.dart';

class Club {
  final String category;
  final String leader;
  final int leaderSchoolNum;
  final String title;
  final String desc;
  final String img;
  final int memberCount;
  final int maxMemberCount;
  final DateTime time;
  final List hashTag;
  final List<CluBUser> participants;

  const Club(
      {required this.category,
      required this.leader,
      required this.leaderSchoolNum,
      required this.title,
      required this.desc,
      required this.img,
      required this.memberCount,
      required this.maxMemberCount,
      required this.time,
      this.hashTag = const [],
      this.participants = const []});
}
