// import 'package:equatable/equatable.dart';
//
// enum EditProfileStatus { initial, loading, success, error }
//
// class ProfileState extends Equatable {
//   final EditProfileStatus uploadImageStatus;
//   final EditProfileStatus getProfileDataStatus;
//   final EditProfileStatus updateProfileStatus;
//   final EditProfileStatus changePasswordStatus;
//   final String? profilePhotoLink;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final String password;
//   final String? error;
//   final String? gender;
//
//   const ProfileState({
//     this.uploadImageStatus = EditProfileStatus.initial,
//     this.getProfileDataStatus = EditProfileStatus.initial,
//     this.updateProfileStatus = EditProfileStatus.initial,
//     this.changePasswordStatus = EditProfileStatus.initial,
//     this.firstName = '',
//     this.lastName = '',
//     this.email = '',
//     this.phoneNumber = '',
//     this.password = '',
//     this.profilePhotoLink,
//     this.error,
//     this.gender,
//   });
//
//   ProfileState copyWith({
//     EditProfileStatus? uploadImageStatus,
//     EditProfileStatus? getProfileDataStatus,
//     EditProfileStatus? changePasswordStatus,
//     EditProfileStatus? updateProfileStatus,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phoneNumber,
//     String? password,
//     String? profilePhotoLink,
//     String? error,
//     String? gender,
//   }) {
//     return ProfileState(
//       uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
//       getProfileDataStatus: getProfileDataStatus ?? this.getProfileDataStatus,
//       changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
//       updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       password: password ?? this.password,
//       profilePhotoLink: profilePhotoLink ?? this.profilePhotoLink,
//       error: error ?? this.error,
//       gender: gender ?? this.gender,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     updateProfileStatus,
//     uploadImageStatus,
//     getProfileDataStatus,
//     changePasswordStatus,
//     firstName,
//     lastName,
//     email,
//     phoneNumber,
//     password,
//     profilePhotoLink,
//     error,
//     gender,
//   ];
//
//   bool isSameAs(ProfileState other) {
//     return firstName == other.firstName &&
//         lastName == other.lastName &&
//         email == other.email &&
//         phoneNumber == other.phoneNumber &&
//         password == other.password &&
//         profilePhotoLink == other.profilePhotoLink &&
//         gender == other.gender;
//   }
// }
import 'package:equatable/equatable.dart';

enum EditProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final EditProfileStatus uploadImageStatus;
  final EditProfileStatus getProfileDataStatus;
  final EditProfileStatus updateProfileStatus;
  final EditProfileStatus changePasswordStatus;
  final String? profilePhotoLink;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? error;
  final String gender;
  final String weight;
  final String goal;
  final String level;

  // ✅ New field to store initial state
  final ProfileState? initialData;

  const ProfileState({
    this.uploadImageStatus = EditProfileStatus.initial,
    this.getProfileDataStatus = EditProfileStatus.initial,
    this.updateProfileStatus = EditProfileStatus.initial,
    this.changePasswordStatus = EditProfileStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.profilePhotoLink,
    this.error,
    this.gender='',
    this.weight='',
    this.goal='',
    this.level='',
    this.initialData, // ✅
  });

  ProfileState copyWith({
    EditProfileStatus? uploadImageStatus,
    EditProfileStatus? getProfileDataStatus,
    EditProfileStatus? changePasswordStatus,
    EditProfileStatus? updateProfileStatus,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? profilePhotoLink,
    String? error,
    String? gender,
    String? weight,
    String? goal,
    String? level,
    ProfileState? initialData, // ✅
  }) {
    return ProfileState(
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
      getProfileDataStatus: getProfileDataStatus ?? this.getProfileDataStatus,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePhotoLink: profilePhotoLink ?? this.profilePhotoLink,
      error: error ?? this.error,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      level: level ?? this.level,
      weight: weight ?? this.weight,
      initialData: initialData ?? this.initialData, // ✅
    );
  }

  @override
  List<Object?> get props => [
    updateProfileStatus,
    uploadImageStatus,
    getProfileDataStatus,
    changePasswordStatus,
    firstName,
    lastName,
    email,
    password,
    profilePhotoLink,
    error,
    gender,
    goal,
    weight,
    level,
    initialData, // ✅
  ];

  // ✅ Compare with the initialData snapshot
  bool get isDirty {
    if (initialData == null) return false;
    return firstName != initialData!.firstName ||
        lastName != initialData!.lastName ||
        email != initialData!.email ||
        weight != initialData!.weight ||
        goal != initialData!.goal ||
        level != initialData!.level;
  }
}
