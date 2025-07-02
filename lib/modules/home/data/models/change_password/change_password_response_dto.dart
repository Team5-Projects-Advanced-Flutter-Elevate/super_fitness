import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';

class ChangePasswordResponseDto {
  ChangePasswordResponseDto({this.message, this.token});

  ChangePasswordResponseDto.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }

  late final String? message;
  late final String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

  ChangePasswordResponseEntity toEntity() {
    return ChangePasswordResponseEntity(message: message, token: token);
  }
}
