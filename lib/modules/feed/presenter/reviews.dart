import 'package:complecionista/common/colors.dart';
import 'package:complecionista/common/error_models.dart';
import 'package:complecionista/common/widgets/side_menu.dart';
import 'package:complecionista/common/theme.dart';
import 'package:complecionista/common/widgets/appbar.dart';
import 'package:complecionista/common/widgets/bottom_appbar.dart';
import 'package:complecionista/common/widgets/tag.dart';
import 'package:complecionista/modules/feed/presenter/cubit/feed_cubit.dart';
import 'package:complecionista/modules/feed/presenter/cubit/feed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:webfeed/webfeed.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  FeedCubit feedCubit = Modular.get<FeedCubit>();
  AppColors appColors = getAppColors();
  RssFeed? feed;

  @override
  void initState() {
    super.initState();
    feedCubit.getEspecificRSSEvent('review');
  }

  @override
  Widget build(BuildContext context) {
    appColors = getAppColors();
    return Scaffold(
      drawer: defaultSideMenu(context),
      bottomNavigationBar: bottomAppBar(context, 'reviews'),
      appBar: defaultAppBar(context, hasLogo: true),
      body: BlocConsumer<FeedCubit, FeedState>(
        bloc: feedCubit,
        listener: (context, state) {
          if (state is FeedErrorState) {
            showErrorModel(context, title: state.failure.message);
          } else if (state is FeedSuccessState && state.data.containsKey('review')) {
            setState(() {
              feed = state.data['review'];
            });
          }
        },
        builder: (BuildContext context, FeedState state) {
          if (state is FeedLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: appColors.mainColor()),
            );
          }

          // print('RSS data: ' + state.data.toString());
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: feed == null
                  ? []
                  : [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(5.0),
                          itemCount: feed?.items?.length,
                          itemBuilder: (BuildContext context, int index) {
                            RssItem item = feed?.items?[index] ?? RssItem();
                            DateTime pubDate = item.pubDate ?? DateTime.now();
                            String timeDifference = DateTime.now().difference(pubDate).inDays > 1
                                ? '${DateTime.now().difference(pubDate).inDays} dias atrás'
                                : DateTime.now().difference(pubDate).inDays == 1
                                    ? '${DateTime.now().difference(pubDate).inDays} dia atrás'
                                    : '${DateTime.now().difference(pubDate).inHours}h atrás';
                            if (index == 0) {
                              // big news
                              List temp = item.categories != null
                                  ? item.categories!.map(
                                      (e) {
                                        if (!e.value.contains('Notícias') && !e.value.contains('Games') && !e.value.contains('Review')) {
                                          return Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            child: getTag(e.value, hasTopMargin: false),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ).toList()
                                  : [];
                              List<Widget> infos = [
                                ...temp,
                                const Spacer(),
                                const Icon(Icons.access_time, size: 10),
                                Container(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    timeDifference,
                                    style: defaultTextTheme.bodyText1?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ];

                              return Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: appColors.grey(),
                                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                                    image: item.content != null && item.content!.images.isNotEmpty
                                        ? DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(item.content!.images.first),
                                          )
                                        : null,
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                                        child: Text(
                                          item.title ?? '',
                                          style: defaultTextTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: appColors.mainColor(),
                                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                                        ),
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          child: Row(
                                            children: infos,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            // other news
                            return Container(
                              padding: const EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height * 0.15,
                              // width: MediaQuery.of(context).size.width * 0.9,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    decoration: BoxDecoration(
                                      color: appColors.grey(),
                                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                                      image: item.content != null && item.content!.images.isNotEmpty
                                          ? DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(item.content!.images.first),
                                            )
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                                            child: Text(
                                              item.title ?? '',
                                              style: defaultTextTheme.bodyText1?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          Row(
                                            children: item.categories != null
                                                ? item.categories!.map(
                                                    (e) {
                                                      if (!e.value.contains('Notícias') && !e.value.contains('Games') && !e.value.contains('Review')) {
                                                        return Container(
                                                          margin: const EdgeInsets.only(left: 5),
                                                          child: getTag(e.value),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  ).toList()
                                                : [Container()],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 5, left: 5),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.access_time, size: 10),
                                                const SizedBox(width: 5),
                                                Text(
                                                  timeDifference,
                                                  style: defaultTextTheme.bodyText1?.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
            ),
          );
        },
      ),
    );
  }
}
