import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:complecionista/modules/feed/infra/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:webfeed/webfeed.dart';

class FeedUsecase implements FeedRepository {
  final FeedRepository _repository = FeedRepository();

  @override
  Future<Either<FeedFailure, RssFeed>> getRSSEvent() async {
    try {
      final result = await _repository.getRSSEvent();
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
      final result = await _repository.getEspecificRSSEvent(categorie);
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
