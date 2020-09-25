import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';

class DataTransformer {
  static List<ArticleAdapter> articleToArticleAdapter(List<Article> articles) {
    var results = <ArticleAdapter>[];
    articles.forEach((article) {
      results.add(ArticleAdapter(
        author: article.by,
        commentCount: article.kids.length.toString(),
        id: article.id.toString(),
        point: article.score.toString(),
        time: DateTime.fromMillisecondsSinceEpoch(article.time).toLocal(),
        sourceUrl: article.url,
        title: article.title,
      ));
    });

    return results;
  }
}
