import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data_entity.dart';
import '../api/api_client/get_data_api_client.dart';
import '../datasource/get_data.dart';
import '../model/get_data.dart';

@Injectable(as: GetLoggedDriverDataOnlineDataSource)
class GetLoggedDriverDataOnlineDataSourceImpl
    implements GetLoggedDriverDataOnlineDataSource {
  final GetDataApiClient _authApiClient;

  GetLoggedDriverDataOnlineDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<GetDataEntity>> getLoggedDriverData() async {
    var apiResult = await ApiExecutor.executeApi(
      () => _authApiClient.getLoggedDriverData(),
    );

    switch (apiResult) {
      case Success<GetData>():
        return Success(data: apiResult.data.toEntity());
      case Error<GetData>():
        return Error(error: apiResult.error);
    }
  }
}
