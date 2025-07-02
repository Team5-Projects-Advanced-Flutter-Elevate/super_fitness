import 'package:super_fitness/modules/edit_profile/domain/entity/user_entity.dart';

class GetDataEntity {
  final String? message;
  final GetUserEntity? user;

  const GetDataEntity({this.message, this.user});
}
