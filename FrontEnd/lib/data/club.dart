import 'package:clu_b/data/my_info.dart';


// flutter: id
// flutter: title
// flutter: description
// flutter: imagePath
// flutter: timeLimit
// flutter: numLimit
// flutter: isThunder
// flutter: isCanceled
// flutter: hashTags
// flutter: createdAt
// flutter: deletedAt
// flutter: __leader__
// flutter: category
// flutter: __members__
// flutter: __has_members__
class Club {
  // final int id;
  final String category;
  final String leader;
  final int leaderSchoolNum;
  final String title;
  final String desc;
  final String imgPath;
  final int memberCount;
  final int maxMemberCount;
  final DateTime time;
  final List hashTag;
  final List<MyInfo> participants;

  const Club(
      {required this.category,
      required this.leader,
      required this.leaderSchoolNum,
      required this.title,
      required this.desc,
      required this.imgPath,
      required this.memberCount,
      required this.maxMemberCount,
      required this.time,
      this.hashTag = const [],
      this.participants = const []});
}
