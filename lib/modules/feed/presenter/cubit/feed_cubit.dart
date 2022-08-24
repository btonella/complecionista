import 'package:bloc/bloc.dart';
import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:complecionista/modules/feed/domain/usecase.dart';
import 'package:complecionista/modules/feed/presenter/cubit/feed_state.dart';
import 'package:webfeed/webfeed.dart';

class FeedCubit extends Cubit<FeedState> {
  final FeedUsecase _usecase = FeedUsecase();

  Map<String, RssFeed> feed = {};

  FeedCubit(FeedState initialState) : super(initialState);

  void resetState() {
    emit(FeedInitialState());
  }

  Future<void> getRSSEvent() async {
    try {
      emit(FeedLoadingState());
      final result = await _usecase.getRSSEvent();
      result.fold((l) {
        emit(FeedErrorState(l));
        return;
      }, (r) async {
        feed['general'] = r;
        emit(FeedSuccessState(data: feed, feedStatus: FeedStatus.getRSSEvent));
        return;
      });
    } catch (e) {
      emit(FeedErrorState(FeedUnkownError(message: e.toString())));
    }
  }

  Future<void> getEspecificRSSEvent(String categorie) async {
    try {
      emit(FeedLoadingState());
      final result = await _usecase.getEspecificRSSEvent(categorie);
      result.fold((l) {
        emit(FeedErrorState(l));
        return;
      }, (r) async {
        feed[categorie] = r;
        emit(FeedSuccessState(data: feed, feedStatus: FeedStatus.getEspecificRSSEvent));
        return;
      });
    } catch (e) {
      emit(FeedErrorState(FeedUnkownError(message: e.toString())));
    }
  }
}
