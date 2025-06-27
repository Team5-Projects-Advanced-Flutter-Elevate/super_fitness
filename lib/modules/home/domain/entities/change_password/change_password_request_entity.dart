class ChangePasswordRequestEntity {
  ChangePasswordRequestEntity({
    this.password,
    this.newPassword,
  });

  late final String? password;
  late final String? newPassword;
}
