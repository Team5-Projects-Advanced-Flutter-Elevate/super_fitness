class EditMyInfoEntity {
  final String? message;
  final DriverEntity? driver;

  EditMyInfoEntity({required this.message, required this.driver});
}

class DriverEntity {
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

  DriverEntity({
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
}
