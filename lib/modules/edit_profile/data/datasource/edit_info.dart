import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/edit_info.dart';

abstract class EditInfoOnlineDataSource {
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? goal,
    String? weight,
    String?level
  );
}
