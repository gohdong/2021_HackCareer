class CluBUser {
  final int id;
  final String nickName;
  final String major;
  final int studentNum;
  final String? imgPath;
  final String intro;
  final List badges;
  final List interest;
  final String gender;
  final int level;
  final DateTime birth;
  final List joinedClubs;
  final List createdClubs;
  final String token;

  CluBUser(
      {required this.nickName,
      required this.id,
      required this.major,
      required this.studentNum,
      required this.imgPath,
      required this.intro,
      required this.badges,
      required this.interest,
      required this.gender,
      required this.level,
      required this.birth,
      required this.joinedClubs,
      required this.createdClubs,
      this.token = ''});

  CluBUser.writerFromJson(Map Json):

}
