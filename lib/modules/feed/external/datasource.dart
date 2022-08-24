import 'package:complecionista/common/routes.dart';
import 'package:complecionista/core/api.dart';
import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:webfeed/webfeed.dart';

FeedFailure getFailureError(Response? response) {
  if (response == null) return FeedUnkownError();
  switch (response.statusCode) {
    case 400:
      return FeedRequestError(message: response.statusMessage, data: response.data);
    case 401:
      return FeedUnauthorizedError(message: response.statusMessage, data: response.data);
    case 403:
      return FeedForbiddenError(message: response.statusMessage, data: response.data);
    case 404:
      return FeedRequestError(message: response.statusMessage, data: response.data);
    case 500:
      return FeedInternalError(message: response.statusMessage, data: response.data);
    default:
      return FeedUnkownError(message: response.statusMessage, code: response.statusCode.toString(), data: response.data);
  }
}

class FeedDatasource {
  final Api _api = Modular.get<Api>();

  Future<Either<FeedFailure, RssFeed>> getRSSEvent() async {
    try {
      Response? response = await _api.getApi(
        'feed',
        ApiRoutes.feed,
      );
      if (response == null || response.statusCode != 200 || response.data == null) {
        FeedFailure failure = getFailureError(response);
        return left(failure);
      } else {
        var resp = RssFeed.parse(response.data);
        return right(resp);
      }
    } catch (e) {
      return left(FeedUnkownError(message: e.toString()));
    }
  }

  Future<Either<FeedFailure, RssFeed>> getEspecificRSSEvent(String categorie) async {
    try {
      Response? response = await _api.getApi(
        'feed',
        '${ApiRoutes.category}/$categorie${ApiRoutes.feed}',
      );
      if (response == null || response.statusCode != 200 || response.data == null) {
        FeedFailure failure = getFailureError(response);
        return left(failure);
      } else {
        var resp = RssFeed.parse(response.data);
        return right(resp);
      }
    } catch (e) {
      return left(FeedUnkownError(message: e.toString()));
    }
  }
}
