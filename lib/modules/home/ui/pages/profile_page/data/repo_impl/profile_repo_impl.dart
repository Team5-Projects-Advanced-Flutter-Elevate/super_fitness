import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';

import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/datasource_contract/profile_datasource.dart';

import '../../domain/repo_contract/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileDatasource _profileDatasource;

  ProfileRepoImpl(this._profileDatasource);

  @override
  Future<ApiResult<UserEntity?>> getProfile() {
    return _profileDatasource.getProfile();
  }
}
