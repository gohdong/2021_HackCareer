class MyInfo {
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

  MyInfo(
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

  MyInfo.fromJson(Map json):
      id=json['id'],
      nickName = json['nickname'],
      major = json['department'],
      studentNum = json['studentNum'],
      intro = json['intro'],
      imgPath = json['imagePath'],
      badges = json['badges'],
      interest = json['interest'],
      gender = json['gender'],
      level = json['level'],
      birth = DateTime.parse(json['birth']),
      joinedClubs = json['joinedClubs'],
      token = '',
      createdClubs = json['createdClubs'];
}
