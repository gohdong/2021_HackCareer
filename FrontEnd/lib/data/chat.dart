import 'package:clu_b/data/user.dart';

class Chat {
  final DateTime sendAt;
  final String contents;
  final User sender;

  Chat({required this.sendAt, required this.contents, required this.sender});
}
