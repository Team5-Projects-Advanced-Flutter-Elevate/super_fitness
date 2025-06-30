import '../../domain/entity/edit_info.dart';

class EditMyInfo {
  EditMyInfo({required this.message, required this.driver});

  final String? message;
  final Driver? driver;

  factory EditMyInfo.fromJson(Map<String, dynamic> json) {
    return EditMyInfo(
      message: json["message"],
      driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "driver": driver?.toJson(),
  };
  EditMyInfoEntity toEntity() =>
      EditMyInfoEntity(message: message, driver: driver?.toEntity());

  factory EditMyInfo.fromEntity(EditMyInfoEntity entity) => EditMyInfo(
    message: entity.message,
    driver: entity.driver != null ? Driver.fromEntity(entity.driver!) : null,
  );
}

class Driver {
  Driver({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.password,
    required this.gender,
    required this.photo,
    required this.role,
    required this.createdAt,
    required this.phone,
  });

  final String? id;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nidImg;
  final String? email;
  final String? password;
  final String? gender;
  final String? photo;
  final String? role;
  final DateTime? createdAt;
  final String? phone;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["_id"],
      country: json["country"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      vehicleType: json["vehicleType"],
      vehicleNumber: json["vehicleNumber"],
      vehicleLicense: json["vehicleLicense"],
      nid: json["NID"],
      nidImg: json["NIDImg"],
      email: json["email"],
      password: json["password"],
      gender: json["gender"],
      photo: json["photo"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "country": country,
    "firstName": firstName,
    "lastName": lastName,
    "vehicleType": vehicleType,
    "vehicleNumber": vehicleNumber,
    "vehicleLicense": vehicleLicense,
    "NID": nid,
    "NIDImg": nidImg,
    "email": email,
    "password": password,
    "gender": gender,
    "photo": photo,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "phone": phone,
  };

  DriverEntity toEntity() => DriverEntity(
    id: id,
    country: country,
    firstName: firstName,
    lastName: lastName,
    vehicleType: vehicleType,
    vehicleNumber: vehicleNumber,
    vehicleLicense: vehicleLicense,
    nid: nid,
    nidImg: nidImg,
    email: email,
    password: password,
    gender: gender,
    photo: photo,
    role: role,
    createdAt: createdAt,
    phone: phone,
  );

  factory Driver.fromEntity(DriverEntity entity) => Driver(
    id: entity.id,
    country: entity.country,
    firstName: entity.firstName,
    lastName: entity.lastName,
    vehicleType: entity.vehicleType,
    vehicleNumber: entity.vehicleNumber,
    vehicleLicense: entity.vehicleLicense,
    nid: entity.nid,
    nidImg: entity.nidImg,
    email: entity.email,
    password: entity.password,
    gender: entity.gender,
    photo: entity.photo,
    role: entity.role,
    createdAt: entity.createdAt,
    phone: entity.phone,
  );
}
