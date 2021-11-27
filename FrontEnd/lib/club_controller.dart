import 'package:clu_b/api_call.dart' as api;
import 'package:clu_b/data/club.dart';
import 'package:get/get.dart';

class ClubController extends GetxController {
  Map joinedClub = <int, Club>{}.obs;
  Map likedClub = <int, Club>{}.obs;
  Map hatedClub = <int, Club>{}.obs;

  void initializeJoinedClub(List<Club> newData) {
    for (Club element in newData) {
      joinedClub[element.id] = element;
    }
  }

  void initializeLikedClub(List<Club> newData) {
    for (Club element in newData) {
      likedClub[element.id] = element;
    }
  }

  Future<bool> joinClub(Club club) async {
    bool result = false;
    await api.joinClub(club.id).then((value) {
      if (value) {
        joinedClub[club.id] = club;
        result = true;
      }
    });
    return result;
  }

  Future<bool> leaveClub(Club club) async {
    bool result = false;
    await api.leaveClub(club.id).then((value) {
      if (value) {
        joinedClub.remove(club.id);
        result = true;
      }
    });
    return result;
  }

  Future<bool> likeClub(Club club) async {
    bool result = false;
    await api.likeClub(club.id).then((value) {
      if (value) {
        likedClub[club.id] = club;
        result = true;
      }
    });
    return result;
  }

  Future<bool> unlikeClub(Club club) async {
    bool result = false;
    await api.unlikeClub(club.id).then((value) {
      if (value) {
        likedClub.remove(club.id);
        result = true;
      }
    });
    return result;
  }

  Future<bool> addHateClub(Club club) async {
    hatedClub[club.id] = club;
    return true;
  }


}
