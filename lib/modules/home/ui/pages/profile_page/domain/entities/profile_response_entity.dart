import 'package:equatable/equatable.dart';

import '../../../../../../authentication/domain/entities/login/login_data_response_entity.dart';

class ProfileResponseEntity extends Equatable {
  final String? message;
  final UserEntity? user;

  const ProfileResponseEntity({this.message, this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [message, user];
}
