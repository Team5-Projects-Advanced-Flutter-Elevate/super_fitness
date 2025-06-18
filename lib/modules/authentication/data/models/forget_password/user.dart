class User {
  String? email;
  String? newPassword;
  String? resetCode;
  User({this.email, this.newPassword, this.resetCode});

  User.fromJson(dynamic json) {
    email = json['email'];
    newPassword = json['newPassword'];
    resetCode = json['resetCode'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['newPassword'] = newPassword;
    map['resetCode'] = resetCode;
    return map;
  }
}
