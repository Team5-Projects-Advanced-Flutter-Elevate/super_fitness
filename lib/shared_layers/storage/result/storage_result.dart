sealed class StorageResult<T> {}

class StorageSuccessResult<T> extends StorageResult<T> {
  T data;

  StorageSuccessResult({required this.data});
}

class StorageErrorResult<T> extends StorageResult<T> {
  Object error;

  StorageErrorResult({required this.error});
}
