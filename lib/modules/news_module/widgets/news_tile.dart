import 'package:flutter/material.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';

class NewsTile extends StatelessWidget {
  final ArticleAdapter article;
  final int index;
  const NewsTile({Key key, this.article, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                DataTransformer.fuzzyDateTime(article.time) + " by ",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.black.withOpacity(.72),
                    ),
              ),
              Text(
                article.author,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.brown,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        DataTransformer.urlShortner(
                          article.sourceUrl,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.black.withOpacity(.72),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Row(
                children: <Widget>[
                  Text(
                    article.commentCount + " comments",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.black.withOpacity(.72),
                        ),
                  ),
                  Text(
                    " · " + article.point + " points",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: Colors.black.withOpacity(.72),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
