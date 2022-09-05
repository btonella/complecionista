import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:complecionista/modules/feed/infra/models/custom_rssfeed.dart';
import 'package:complecionista/modules/feed/infra/models/custom_rssitem.dart';
import 'package:complecionista/modules/feed/infra/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:webfeed/webfeed.dart';

class FeedUsecase implements FeedRepository {
  final FeedRepository _repository = FeedRepository();
  final List<String> _ignoreList = ['NOTÍCIAS', 'GAMES', 'REVIEW', 'REVIEWS', 'DESTAQUE'];
  final List<String> _ignoreYearsList = ['2021', '2022', '2023'];

  @override
  Future<Either<FeedFailure, CustomRssFeed>> getRSSEvent() async {
    try {
      final result = await _repository.getRSSEvent();
      return result.fold((l) {
        return left(l);
      }, (r) {
        for (CustomRssItem element in r.items ?? []) {
          int maxLenght = 0;
          List<RssCategory> ignoreCategories = [];
          List<RssCategory> newCategories = [];
          List<RssCategory> _categories = element.categories ?? [];
          for (RssCategory e in _categories) {
            if (_ignoreList.contains(e.value.toUpperCase())) {
              ignoreCategories.add(e);
              continue;
            }
            if (e.value.contains(_ignoreYearsList.first) || e.value.contains(_ignoreYearsList[1]) || e.value.contains(_ignoreYearsList.last)) continue;
            if (maxLenght < 29 && newCategories.length < 4 && (maxLenght + e.value.length) < 29) {
              maxLenght += e.value.length;
              newCategories.add(e);
            } else {
              break;
            }
          }
          element.categories = newCategories;
          element.categories!.addAll(ignoreCategories);
        }

        return right(r);
      });
    } catch (e) {
      return left(FeedUnkownError(message: e.toString()));
    }
  }

  @override
  Future<Either<FeedFailure, CustomRssFeed>> getEspecificRSSEvent(String categorie) async {
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
