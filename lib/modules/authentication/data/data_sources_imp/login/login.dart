import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/apis/api_result/api_result.dart';
import 'package:super_fitness/modules/authentication/data/data_sources_contracts/login/login.dart';
import 'package:super_fitness/modules/authentication/data/models/login/login.dart';
import 'package:super_fitness/modules/authentication/domain/entities/login/login_data_response_entity.dart';

import '../../../../../core/apis/api_executor/api_executor.dart';
import '../../api/api_client/auth_api_client.dart';

@Injectable(as: LoginOnlineDataSource)
class LoginOnlineDataSourceImpl implements LoginOnlineDataSource {
  final AuthApiClient _apiClient;

  LoginOnlineDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<LoginEntity>> login(String email, String password) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _apiClient.login({"email": email, "password": password}),
    );
    switch (apiResult) {
      case Success<LoginModel>():
        return Success(data: apiResult.data.toEntity());
      case Error<LoginModel>():
        return Error(error: apiResult.error);
    }
  }
}
