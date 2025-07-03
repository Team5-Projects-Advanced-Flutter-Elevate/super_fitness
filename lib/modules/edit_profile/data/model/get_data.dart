import 'package:super_fitness/modules/edit_profile/domain/entity/get_data_entity.dart';

import '../../domain/entity/user_entity.dart';

class GetData {
  GetData({required this.message, required this.user});

  final String? message;
  final User? user;

  factory GetData.fromJson(Map<String, dynamic> json) {
    return GetData(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {"message": message, "user": user?.toJson()};
  GetDataEntity toEntity() =>
      GetDataEntity(message: message, user: user?.toEntity());
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.activityLevel,
    required this.goal,
    required this.photo,
    required this.createdAt,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final num? age;
  final num? weight;
  final num? height;
  final String? activityLevel;
  final String? goal;
  final String? photo;
  final DateTime? createdAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      gender: json["gender"],
      age: json["age"],
      weight: json["weight"],
      height: json["height"],
      activityLevel: json["activityLevel"],
      goal: json["goal"],
      photo: json["photo"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "age": age,
    "weight": weight,
    "height": height,
    "activityLevel": activityLevel,
    "goal": goal,
    "photo": photo,
    "createdAt": createdAt?.toIso8601String(),
  };
  GetUserEntity toEntity() => GetUserEntity(
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
