enum ResponseStatus { Success, Error, Unreachable }

const String? defaultError = 'Unknown error';

class BaseResult<T> {
  BaseResult(
    this.status,
    this.data, {
    this.errorMessage = defaultError,
  });

  final ResponseStatus status;
  final T? data;
  final String? errorMessage;

  static BaseResult<T> success<T>(T data) =>
      BaseResult(ResponseStatus.Success, data);

  static BaseResult<T> failed<T>(
          {int? status = -1, T? error, String? message}) =>
      BaseResult(
        ResponseStatus.Error,
        error,
        errorMessage: message ?? defaultError,
      );

  static BaseResult<T> timeout<T>(String? message) => BaseResult(
        ResponseStatus.Unreachable,
        null,
        errorMessage: message ?? defaultError,
      );
}
