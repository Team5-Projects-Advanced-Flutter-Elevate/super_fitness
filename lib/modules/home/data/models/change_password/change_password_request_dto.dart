import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_request_entity.dart';

/// password : "Mohamed@1234"
/// newPassword : "Ahmed@1234"
class ChangePasswordRequestDto {
  ChangePasswordRequestDto({
    this.password,
    this.newPassword,
  });

  ChangePasswordRequestDto.fromJson(dynamic json) {
    password = json['password'];
    newPassword = json['newPassword'];
  }

  late final String? password;
  late final String? newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = password;
    map['newPassword'] = newPassword;
    return map;
  }

  static ChangePasswordRequestDto convertIntoDto(
    ChangePasswordRequestEntity entity,
  ) {
    return ChangePasswordRequestDto(
      password: entity.password,
      newPassword: entity.newPassword,
    );
  }
}
