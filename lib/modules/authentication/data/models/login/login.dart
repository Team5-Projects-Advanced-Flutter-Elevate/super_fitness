import '../../../domain/entities/login/login_data_response_entity.dart';

class LoginModel {
  LoginModel({required this.message, required this.user, required this.token});

  final String? message;
  final User? user;
  final String? token;

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "token": token,
  };
}

extension LoginModelMapper on LoginModel {
  LoginEntity toEntity() {
    return LoginEntity(message: message, user: user?.toEntity(), token: token);
  }

  static LoginModel fromEntity(LoginEntity entity) {
    return LoginModel(
      message: entity.message,
      user: entity.user != null ? User.fromEntity(entity.user!) : null,
      token: entity.token,
    );
  }
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
  // Convert to entity
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

  // Convert from entity
  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      gender: entity.gender,
      age: entity.age,
      weight: entity.weight,
      height: entity.height,
      activityLevel: entity.activityLevel,
      goal: entity.goal,
      photo: entity.photo,
      createdAt: entity.createdAt,
    );
  }
}
