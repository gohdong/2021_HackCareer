class User {
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

  User(
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
      });

  User.fromJson(Map json):
        id=json['id'],
        nickName = json['nickname'],
        major = json['department'],
        studentNum = int.parse(json['studentNum']),
        intro = json['intro'],
        imgPath = json['imagePath'],
        badges = json['badges'],
        interest = json['interest'],
        gender = json['gender'],
        level = int.parse(json['level']),
        birth = DateTime.parse(json['birth']);



}
