class ForgetPasswordResponse {
  ForgetPasswordResponse({this.message, this.token, this.info});

  ForgetPasswordResponse.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    info = json['info'];
  }
  String? message;
  String? token;
  String? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    map['info'] = info;
    return map;
  }
}
