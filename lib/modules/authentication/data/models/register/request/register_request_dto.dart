import 'package:super_fitness/modules/authentication/domain/entities/register/request/register_request_entity.dart';

/// firstName : "Elevate"
/// lastName : "Tech"
/// email : "ahmedmutti22@gmail.com"
/// password : "Ahmed@123"
/// rePassword : "Ahmed@123"
/// gender : "male"
/// height : 170
/// weight : 70
/// age : 70
/// goal : "Gain weight"
/// activityLevel : "level1"
class RegisterRequestDto {
  RegisterRequestDto({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
  });

  RegisterRequestDto.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    goal = json['goal'];
    activityLevel = json['activityLevel'];
  }

  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? password;
  late final String? rePassword;
  late final String? gender;
  late final num? height;
  late final num? weight;
  late final num? age;
  late final String? goal;
  late final String? activityLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['gender'] = gender;
    map['height'] = height;
    map['weight'] = weight;
    map['age'] = age;
    map['goal'] = goal;
    map['activityLevel'] = activityLevel;
    return map;
  }

  static RegisterRequestDto convertIntDto(RegisterRequestEntity entity) {
    return RegisterRequestDto(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      gender: entity.gender,
      height: entity.height,
      weight: entity.weight,
      age: entity.age,
      goal: entity.goal,
      activityLevel: entity.activityLevel,
    );
  }
}
