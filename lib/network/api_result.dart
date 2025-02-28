sealed class ApiResult<T> {
  const ApiResult();
}

class APISuccess<T> extends ApiResult<T> {
  final T data;
  const APISuccess(this.data);
}

class APIError<T> extends ApiResult<T> {
  final String? message;
  const APIError(this.message);
}