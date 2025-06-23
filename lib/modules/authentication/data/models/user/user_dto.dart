import 'package:super_fitness/modules/authentication/domain/entities/user/user_entity.dart';

/// firstName : "Mohammed"
/// lastName : "Khalil"
/// email : "aklilmohammed9@gmail.com"
/// gender : "male"
/// age : 70
/// weight : 70
/// height : 170
/// activityLevel : "level1"
/// goal : "Gain weight"
/// photo : "default-profile.png"
/// _id : "68530fc3db652005144160e6"
/// createdAt : "2025-06-18T19:13:07.342Z"
class UserDto {
  UserDto({
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
    this.id,
    this.createdAt,
  });

  UserDto.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    activityLevel = json['activityLevel'];
    goal = json['goal'];
    photo = json['photo'];
    id = json['_id'];
    createdAt = json['createdAt'];
  }

  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? gender;
  late final num? age;
  late final num? weight;
  late final num? height;
  late final String? activityLevel;
  late final String? goal;
  late final String? photo;
  late final String? id;
  late final String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['age'] = age;
    map['weight'] = weight;
    map['height'] = height;
    map['activityLevel'] = activityLevel;
    map['goal'] = goal;
    map['photo'] = photo;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    return map;
  }

  UserEntity convertIntoEntity() {
    return UserEntity(
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
      id: id,
    );
  }
}
