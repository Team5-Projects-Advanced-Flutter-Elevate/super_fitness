import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data_entity.dart';

abstract interface class GetLoggedDriverDataOnlineDataSource {
  Future<ApiResult<GetDataEntity>> getLoggedDriverData();
}
