// ignore_for_file: overridden_fields

import 'package:complecionista/modules/feed/infra/models/custom_rssitem.dart';
import 'package:webfeed/webfeed.dart';

class CustomRssFeed extends RssFeed {
  @override
  String? title;
  @override
  String? author;
  @override
  String? description;
  @override
  String? link;
  @override
  List<CustomRssItem>? items;
  @override
  RssImage? image;
  @override
  List<RssCategory>? categories;

  CustomRssFeed({
    this.title,
    this.author,
    this.description,
    this.link,
    this.items,
    this.image,
    this.categories,
  });

  static CustomRssFeed copy(RssFeed item) {
    return CustomRssFeed(
      title: item.title,
      author: item.author,
      description: item.description,
      link: item.link,
      items: CustomRssItem.copy(item.items ?? []),
      image: item.image,
      categories: item.categories,
    );
  }
}
