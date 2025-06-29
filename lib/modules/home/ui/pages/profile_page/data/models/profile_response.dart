import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/domain/entities/profile_response_entity.dart';

import '../../../../../../authentication/domain/entities/login/login_data_response_entity.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDM? user;

  ProfileResponse({this.message, this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }

  ProfileResponseEntity toEntity() {
    return ProfileResponseEntity(message: message, user: user?.toEntity());
  }
}

@JsonSerializable()
class UserDM {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "age")
  final int? age;
  @JsonKey(name: "weight")
  final int? weight;
  @JsonKey(name: "height")
  final int? height;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  UserDM({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.photo,
    this.createdAt,
  });

  factory UserDM.fromJson(Map<String, dynamic> json) {
    return _$UserDMFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDMToJson(this);
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      photo: photo,
      createdAt: createdAt,
    );
  }
}
