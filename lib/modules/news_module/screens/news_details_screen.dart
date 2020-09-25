import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';

class NewsDetailsScreen extends StatefulWidget {
  final ArticleAdapter article;

  const NewsDetailsScreen({Key key, this.article}) : super(key: key);
  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CupertinoSlidingSegmentedControl(
            children: {1: Text("News"), 2: Text("Comments")},
            onValueChanged: (v) {},
          ),
        ],
      ),
    );
  }
}
