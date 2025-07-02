import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

import '../../../../../../../core/apis/api_result/api_result.dart';

abstract interface class ProfileRepo {
  Future<ApiResult<UserEntity?>> getProfile();
}
