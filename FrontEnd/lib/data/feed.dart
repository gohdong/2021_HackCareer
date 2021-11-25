import 'package:clu_b/data/user.dart';

class Feed {
  final int id;
  final String description;
  final List<dynamic> imagePath;
  final DateTime createdAt;
  // final CluBUser writer;
  final String category;
  final int commentCount;
  final int likeCount;

  Feed({
    required this.id,
    required this.description,
    this.imagePath = const [],
    required this.createdAt,
    // required this.writer,
    required this.category,
    required this.commentCount,
    required this.likeCount,
  });

  Feed.fromJson(Map first):

    id= first['id'],
    description= first['description'],
    imagePath= first['imagePath'],
    createdAt= DateTime.parse(first['createdAt']),
    commentCount= first['__comments__'].length,
    likeCount= first['__likeUsers__'].length,
    category= first['__category__']['categoryTitle'];
}

