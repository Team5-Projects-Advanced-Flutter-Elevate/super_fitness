class RegisterRequestEntity {
  RegisterRequestEntity({
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
}
