import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:complecionista/modules/feed/external/datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:webfeed/webfeed.dart';

class FeedRepository implements FeedDatasource {
  final FeedDatasource _datasource = FeedDatasource();

  @override
  Future<Either<FeedFailure, RssFeed>> getRSSEvent() async {
    try {
      final result = await _datasource.getRSSEvent();
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(FeedUnkownError(message: e.toString()));
    }
  }

  @override
  Future<Either<FeedFailure, RssFeed>> getEspecificRSSEvent(String categorie) async {
    try {
      final result = await _datasource.getEspecificRSSEvent(categorie);
      return result.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    } catch (e) {
      return left(FeedUnkownError(message: e.toString()));
    }
  }
}
