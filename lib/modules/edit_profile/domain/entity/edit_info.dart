import 'package:super_fitness/modules/edit_profile/domain/entity/user_entity.dart';

class EditMyInfoEntity {
  final String? message;
  final GetUserEntity? user;

  const EditMyInfoEntity({this.message, this.user});
}
