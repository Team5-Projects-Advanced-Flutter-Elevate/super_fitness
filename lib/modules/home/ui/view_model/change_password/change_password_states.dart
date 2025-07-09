import 'package:equatable/equatable.dart';

enum ChangePasswordStatus { initial, loading, success, error }

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus changePasswordStatus;
  final String password;
  final Object? error;

  final ChangePasswordState? initialData;

  const ChangePasswordState({
    this.changePasswordStatus = ChangePasswordStatus.initial,
    this.password = '',
    this.error,
    this.initialData,
  });

  ChangePasswordState copyWith({
    ChangePasswordStatus? changePasswordStatus,
    String? password,
    String? profilePhotoLink,
    Object? error,
    ChangePasswordState? initialData, // ✅
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      password: password ?? this.password,
      error: error ?? this.error,
      initialData: initialData ?? this.initialData,
    );
  }

  @override
  List<Object?> get props => [
    changePasswordStatus,
    password,
    error,
    initialData,
  ];
}
