import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';

abstract class UsersCollection {
  Future<List<UserDto>> searchForUserWithId(String id);

  Future<void> addUser(UserDto userDto);

  Future<void> addUserWithId(String id);
}
