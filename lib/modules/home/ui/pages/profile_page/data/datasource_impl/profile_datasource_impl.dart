import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_executor/api_executor.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/api/api_client/profile_api_client.dart';
import 'package:super_fitness/modules/home/ui/pages/profile_page/data/models/profile_response.dart';
import '../../../../../../authentication/domain/entities/login/login_data_response_entity.dart';
import '../datasource_contract/profile_datasource.dart';

@Injectable(as: ProfileDatasource)
class ProfileDatasourceImpl implements ProfileDatasource {
  final ProfileApiClient _profileApiClient;

  ProfileDatasourceImpl(this._profileApiClient);

  @override
  Future<ApiResult<UserEntity?>> getProfile() async {
    var result = await ApiExecutor.executeApi(
      () => _profileApiClient.getProfile(),
    );
    switch (result) {
      case Success<ProfileResponse>():
        return Success(data: result.data.user?.toEntity());
      case Error<ProfileResponse>():
        return Error(error: result.error);
    }
  }
}
