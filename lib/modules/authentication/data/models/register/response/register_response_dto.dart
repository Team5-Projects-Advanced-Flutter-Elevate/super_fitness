import 'package:super_fitness/modules/authentication/data/models/user/user_dto.dart';
import 'package:super_fitness/modules/authentication/domain/entities/register/response/register_response_entity.dart';

/// message : "success"
/// user : {"firstName":"Mohammed","lastName":"Khalil","email":"aklilmohammed9@gmail.com","gender":"male","age":70,"weight":70,"height":170,"activityLevel":"level1","goal":"Gain weight","photo":"default-profile.png","_id":"68530fc3db652005144160e6","createdAt":"2025-06-18T19:13:07.342Z"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjg1MzBmYzNkYjY1MjAwNTE0NDE2MGU2IiwiaWF0IjoxNzUwMjczOTg3fQ.4ynZANPoHbSBSGkYaHztECPAqPpeCG02mL2mauxwOLk"
class RegisterResponseDto {
  RegisterResponseDto({this.message, this.user, this.token});

  RegisterResponseDto.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }

  String? message;
  UserDto? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

  RegisterResponseEntity convertIntoEntity() {
    return RegisterResponseEntity(
      message: message,
      user: user?.convertIntoEntity(),
      token: token,
    );
  }
}
