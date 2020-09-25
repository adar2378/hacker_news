import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/news_module/adapters/comment_adapter.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class DataTransformer {
  /// Transforming [List<NewsData>] to [List<ArticleAdapter>]
  static List<ArticleAdapter> articleToArticleAdapter(List<NewsData> articles) {
    var results = <ArticleAdapter>[];

    articles.forEach((article) {
      results.add(ArticleAdapter(
        author: article.by,
        commentCount: article.kids == null ? "0" : article.kids.length.toString(),
        id: article.id.toString(),
        point: article.score.toString(),
        time: DateTime.fromMillisecondsSinceEpoch(article.time * 1000).toLocal(),
        sourceUrl: article.url,
        title: article.title,
        comments: article.kids,
      ));
    });

    return results;
  }

  /// Transforming [List<NewsData>] to [List<CommentAdapter>]
  static List<CommentAdapter> commentToCommentAdapter(List<NewsData> comments) {
    var results = <CommentAdapter>[];

    comments.forEach((article) {
      results.add(CommentAdapter(
        author: article.by,
        id: article.id.toString(),
        childComments: article.kids,
        text: article.text,
        time: DateTime.fromMillisecondsSinceEpoch(article.time * 1000).toLocal(),
      ));
    });

    return results;
  }

  /// Converting normal [DateTime] to fuzzy time
  static String fuzzyDateTime(DateTime dateTime) {
    final result = timeAgo.format(
      dateTime,
    );
    return result;
  }

  static String urlShortner(String url) {
    try {
      var uri = Uri.parse(url);
      var source = uri.origin;
      source = source.replaceAll("http://", "");
      source = source.replaceAll("https://", "");
      return source;
    } catch (e) {
      return "";
    }
  }
}
