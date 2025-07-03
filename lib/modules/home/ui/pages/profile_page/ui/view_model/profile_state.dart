part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserEntity? userEntity;
  final Object? getProfileError;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userEntity,
    this.getProfileError,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserEntity? userEntity,
    Object? getProfileError,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userEntity: userEntity ?? this.userEntity,
      getProfileError: getProfileError ?? this.getProfileError,
    );
  }

  @override
  List<Object?> get props => [status, userEntity, getProfileError];
}
