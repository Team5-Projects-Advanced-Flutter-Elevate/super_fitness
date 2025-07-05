import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? message;
  final UserEntity? user;
  final String? token;

  const LoginEntity({this.message, this.user, this.token});

  LoginEntity copyWith({String? message, UserEntity? user, String? token}) {
    return LoginEntity(
      message: message ?? this.message,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [message, user, token];
}

// user_entity.dart
class UserEntity extends Equatable {
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

  const UserEntity({
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

  UserEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    num? age,
    num? weight,
    num? height,
    String? activityLevel,
    String? goal,
    String? photo,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get fullName => '$firstName $lastName';

  bool get hasNetworkImage => photo != null && photo!.startsWith('http');

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    photo,
    createdAt,
  ];
}
