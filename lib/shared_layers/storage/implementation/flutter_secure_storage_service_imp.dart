import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../constants/storage_constants.dart';
import '../contracts/flutter_secure_storage_service_contract.dart';
import '../handler/storage_execution_handler.dart';
import '../result/storage_result.dart';

@Singleton(as: SecureStorageService)
class SecureStorageServiceImp implements SecureStorageService {
  final FlutterSecureStorage storageInstance;

  SecureStorageServiceImp(this.storageInstance);

  @override
  void setStringValue(String key, String value) async {
    var storageResult = await StorageExecutionHandler.execute<void>(
      () => storageInstance.write(key: key, value: value),
    );
    if (storageResult is StorageErrorResult) {
      debugPrint(
        StorageConstants.errorStoringMessage(storageResult.error.toString()),
      );
    }
  }

  @override
  Future<String?> getStringValue(String key) async {
    var storageResult = await StorageExecutionHandler.execute(
      () => storageInstance.read(key: key),
    );
    switch (storageResult) {
      case StorageSuccessResult<String?>():
        return storageResult.data;
      case StorageErrorResult<String?>():
        debugPrint(
          StorageConstants.errorReadingMessage(storageResult.error.toString()),
        );
    }
    return null;
  }

  @override
  Future<void> deleteValue(String key) async {
    var storageResult = await StorageExecutionHandler.execute(
      () => storageInstance.delete(key: key),
    );
    if (storageResult is StorageErrorResult) {
      debugPrint(
        StorageConstants.errorDeletingMessage(storageResult.error.toString()),
      );
    }
  }
}
