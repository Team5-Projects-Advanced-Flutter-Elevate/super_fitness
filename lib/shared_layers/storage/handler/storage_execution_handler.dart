import '../result/storage_result.dart';

abstract class StorageExecutionHandler {
  static Future<StorageResult<T>> execute<T>(
    Future<T> Function() storageFunction,
  ) async {
    try {
      var result = await storageFunction();
      return StorageSuccessResult(data: result);
    } catch (e) {
      return StorageErrorResult(error: e);
    }
  }
}
