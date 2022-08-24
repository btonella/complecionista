import 'package:complecionista/modules/feed/domain/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:webfeed/webfeed.dart';

enum FeedStatus { getRSSEvent, updateRSSEvent, getEspecificRSSEvent, updateEspecificRSSEvent }

abstract class FeedState extends Equatable {}

class FeedInitialState extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoadingState extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedSuccessState extends FeedState {
  final Map<String, RssFeed> data;
  final FeedStatus feedStatus;
  FeedSuccessState({required this.data, required this.feedStatus});

  @override
  List<Object> get props => [];
}

class FeedErrorState extends FeedState {
  final FeedFailure failure;
  FeedErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
