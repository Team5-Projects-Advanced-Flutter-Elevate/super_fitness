import '../../../../core/apis/api_result/api_result.dart';
import '../entity/get_data_entity.dart';

abstract interface class GetLoggedDriverDataRepo {
  Future<ApiResult<GetDataEntity>> getLoggedDriverData();
}
