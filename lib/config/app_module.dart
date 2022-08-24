// ignore_for_file: prefer_const_constructors

import 'package:complecionista/config/app_flavor.dart';
import 'package:complecionista/config/app_preferences.dart';
import 'package:complecionista/core/api.dart';
import 'package:complecionista/modules/feed/presenter/books.dart';
import 'package:complecionista/modules/feed/presenter/cubit/feed_cubit.dart';
import 'package:complecionista/modules/feed/presenter/cubit/feed_state.dart';
import 'package:complecionista/modules/feed/presenter/events.dart';
import 'package:complecionista/modules/feed/presenter/games.dart';
import 'package:complecionista/modules/feed/presenter/movies.dart';
import 'package:complecionista/modules/feed/presenter/news.dart';
import 'package:complecionista/modules/feed/presenter/podcast.dart';
import 'package:complecionista/modules/feed/presenter/reviews.dart';
import 'package:complecionista/modules/feed/presenter/series.dart';
import 'package:complecionista/modules/feed/presenter/shop.dart';
import 'package:complecionista/modules/feed/presenter/videos.dart';
import 'package:complecionista/modules/login/presenter/login.dart';
import 'package:complecionista/modules/splash/presenter/splash.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  AppModule();

  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),

        // cubit
        // Bind((i) => LoginCubit(LoginInitialState())),
        Bind((i) => FeedCubit(FeedInitialState())),

        // configs
        Bind((i) => AppPreferences()),
        Bind((i) => AppFlavor()),
        Bind((i) => Api()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashScreen()),

        // login
        ChildRoute('/login', child: (context, args) => LoginPage()),

        // news
        ChildRoute('/news', child: (context, args) => NewsPage()),

        // videos
        ChildRoute('/videos', child: (context, args) => VideosPage()),

        // podcasts
        ChildRoute('/podcasts', child: (context, args) => PodcastPage()),

        // reviews
        ChildRoute('/reviews', child: (context, args) => ReviewsPage()),

        // reviews
        ChildRoute('/books', child: (context, args) => BooksPage()),

        // reviews
        ChildRoute('/events', child: (context, args) => EventsPage()),

        // reviews
        ChildRoute('/games', child: (context, args) => GamesPage()),

        // reviews
        ChildRoute('/movies', child: (context, args) => MoviesPage()),

        // reviews
        ChildRoute('/series', child: (context, args) => SeriesPage()),

        // reviews
        ChildRoute('/shop', child: (context, args) => ShopPage()),
      ];
}
