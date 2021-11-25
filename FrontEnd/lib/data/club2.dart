import 'package:clu_b/data/user.dart';

class Club2{
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final DateTime timeLimit;
  final int numLimit;
  final bool isNow;
  final bool isCanceled;
  final List hashTags;
  final DateTime createdAt;
  final User leader;
  final String category;
  final int memberCount;
  List<User> members;

  Club2({
    required this.id,
    required this.title,
    required this.description,
    this.imagePath = '',
    required this.timeLimit,
    required this.numLimit,
    required this.isCanceled,
    this.hashTags = const [],
    required this.createdAt,
    required this.leader,
    required this.category,
    required this.memberCount,
    required this.isNow,
    this.members = const [],
});

  Club2.fromJson(Map json):
      id = json['id'],
      title = json['title'],
      description = json['description'],
      imagePath = json['imagePath']??'',
      timeLimit = DateTime.parse(json['timeLimit']),
      numLimit = json['numLimit'],
      isNow = json['isThunder'],
      isCanceled = json['isCanceled'],
      hashTags = json['hashTags'],
      createdAt = DateTime.parse(json['createdAt']),
      leader = User.fromJson(json['__leader__']),
      category = json['category']['categoryTitle'],
      memberCount = json['__members__'].length,
      members = [];


  void setMembers(List<User> users){
    members = users;
  }
}