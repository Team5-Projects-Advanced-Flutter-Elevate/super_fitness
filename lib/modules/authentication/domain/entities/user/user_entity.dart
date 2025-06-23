class UserEntity {
  UserEntity({
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
  });

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
}
