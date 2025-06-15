sealed class ApiResult<T> {}

class Success<T> extends ApiResult<T> {
  T data;

  Success({required this.data});
}

class Error<T> extends ApiResult<T> {
  Object error;

  Error({required this.error});
}
