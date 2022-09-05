// ignore_for_file: overridden_fields

import 'package:webfeed/domain/media/media.dart';
import 'package:webfeed/domain/rss_content.dart';
import 'package:webfeed/webfeed.dart';

class CustomRssItem extends RssItem {
  @override
  String? title;
  @override
  String? description;
  @override
  String? link;

  @override
  List<RssCategory>? categories;
  @override
  DateTime? pubDate;
  @override
  String? author;
  @override
  String? comments;
  @override
  RssSource? source;
  @override
  RssContent? content;
  @override
  Media? media;

  CustomRssItem({
    this.title,
    this.description,
    this.link,
    this.categories,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
  });

  static List<CustomRssItem> copy(List<RssItem> items) {
    return items.map((e) {
      return CustomRssItem(
        title: e.title,
        description: e.description,
        link: e.link,
        categories: e.categories,
        pubDate: e.pubDate,
        author: e.author,
        comments: e.comments,
        content: e.content,
        media: e.media,
      );
    }).toList();
  }
}
