import 'package:super_fitness/modules/home/domain/entities/change_password/change_password_response_entity.dart';

/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjg1ODE3YmVkYjY1MjAwNTE0NDE3NDUwIiwiaWF0IjoxNzUwOTg1MjM1fQ.s6zjR3i_WaCVjua5YpHvKAwXjeSMc3tEdmrLGwRu6iA"
class ChangePasswordResponseDto {
  ChangePasswordResponseDto({
    this.message,
    this.token,
  });

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
