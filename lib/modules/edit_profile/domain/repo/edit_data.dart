import '../../../../core/apis/api_result/api_result.dart';
import '../entity/edit_info.dart';

abstract class EditInfoRepo {
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? goal,
    String? weight,
    String? level,
  );
}
