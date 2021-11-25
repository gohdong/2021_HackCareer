class User {
  late String nickName;
  late String major;
  late int schoolNum;
  late String img;

  User(
      {required this.nickName,
      required this.major,
      required this.schoolNum,
      required this.img});

  User.fromJson(Map json) {
    nickName = json['nick'];
    major = "";
    schoolNum = 17;
    img = "";
  }
}
