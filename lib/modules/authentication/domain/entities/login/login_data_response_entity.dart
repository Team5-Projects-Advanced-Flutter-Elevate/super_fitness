class LoginEntity {
  final String? message;
  final UserEntity? user;
  final String? token;

  LoginEntity({this.message, this.user, this.token});
}

// user_entity.dart
class UserEntity {
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

  UserEntity({
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
}
