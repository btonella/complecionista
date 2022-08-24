abstract class FeedFailure implements Exception {
  String? get message;
  String? get code;
  get data;
}

class FeedRequestError implements FeedFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FeedRequestError({this.message, this.code, this.data});
}

class FeedUnauthorizedError implements FeedFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FeedUnauthorizedError({this.message, this.code, this.data});
}

class FeedForbiddenError implements FeedFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FeedForbiddenError({this.message, this.code, this.data});
}

class FeedInternalError implements FeedFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FeedInternalError({this.message, this.code, this.data});
}

class FeedUnkownError implements FeedFailure {
  @override
  final String? message;
  @override
  final String? code;
  @override
  final dynamic data;
  FeedUnkownError({this.message, this.code, this.data});
}
