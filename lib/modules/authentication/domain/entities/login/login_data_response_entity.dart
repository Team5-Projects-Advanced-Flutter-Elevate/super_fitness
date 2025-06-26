import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? message;
  final UserEntity? user;
  final String? token;

  const LoginEntity({this.message, this.user, this.token});

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
