import 'package:super_fitness/modules/authentication/domain/entities/user/user_entity.dart';

class RegisterResponseEntity {
  RegisterResponseEntity({this.message, this.user, this.token});

  String? message;
  UserEntity? user;
  String? token;
}
