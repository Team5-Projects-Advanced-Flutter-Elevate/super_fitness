import '../api_result/api_result.dart';

abstract class ApiExecutor {
  static Future<ApiResult<T>> executeApi<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      var result = await apiCall.call();
      return Success(data: result);
    } catch (error) {
      return Error(error: error);
    }
  }
}
