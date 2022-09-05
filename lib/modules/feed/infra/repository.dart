import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:complecionista/modules/feed/external/datasource.dart';
import 'package:complecionista/modules/feed/infra/models/custom_rssfeed.dart';
import 'package:dartz/dartz.dart';

class FeedRepository implements FeedDatasource {
  final FeedDatasource _datasource = FeedDatasource();

  @override
  Future<Either<FeedFailure, CustomRssFeed>> getRSSEvent() async {
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
  Future<Either<FeedFailure, CustomRssFeed>> getEspecificRSSEvent(String categorie) async {
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
