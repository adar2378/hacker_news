import 'package:flutter/material.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/styles/font_styles.dart';

class NewsTile extends StatelessWidget {
  final ArticleAdapter article;
  final int index;
  final bool hideLeading;
  final double verticalPadding;
  const NewsTile({Key key, this.article, this.index, this.hideLeading = false, this.verticalPadding = 16})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!hideLeading)
            Container(
              width: 60,
              height: 60,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  (index + 1).toString(),
                  style: FontStyles.title2,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  article.title,
                  style: FontStyles.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      DataTransformer.urlShortner(article.sourceUrl),
                      style: FontStyles.caption.copyWith(
                        color: Colors.black.withOpacity(.72),
                        fontSize: 14,
                      ),
                    ),
                    Text(" by "),
                    Text(
                      "${article.author}",
                      style: FontStyles.caption.copyWith(
                        color: Colors.brown,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "${article.point} points",
                      style: FontStyles.caption,
                    ),
                    Text(
                      " · ${article.commentCount} comments",
                      style: FontStyles.caption,
                    ),
                    Text(
                      " · ${DataTransformer.fuzzyDateTime(article.time)}",
                      style: FontStyles.caption,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
