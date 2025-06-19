import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/modules/authentication/core/constants/firebase_constants.dart';
import 'package:super_fitness/modules/authentication/data/collections/users/user_collection.dart';
import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';

@Injectable(as: UsersCollection)
class UsersCollectionImp implements UsersCollection {
  CollectionReference<UserDto> _getUsersCollection() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore
        .collection(FirebaseConstants.usersCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return UserDto.fromJson(snapshot.data());
          },
          toFirestore: (userDto, options) {
            return userDto.toJson();
          },
        );
  }

  @override
  Future<List<UserDto>> searchForUserWithId(String id) async {
    var querySnapshot =
        await _getUsersCollection().where("id", isEqualTo: id).get();

    return querySnapshot.docs.map((e) => e.data()).toList();
  }

  @override
  Future<void> addUser(UserDto userDto) {
    return _getUsersCollection().doc(userDto.id).set(userDto);
  }

  @override
  Future<void> addUserWithId(String id) {
    return _getUsersCollection().doc(id).delete();
  }
}
