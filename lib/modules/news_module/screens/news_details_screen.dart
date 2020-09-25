import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/news_module/widgets/news_tile.dart';
import 'package:hacker_news/styles/font_styles.dart';

import 'web_view.dart';

class NewsDetailsScreen extends StatefulWidget {
  final ArticleAdapter article;

  const NewsDetailsScreen({Key key, this.article}) : super(key: key);
  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> with SingleTickerProviderStateMixin {
  int groupValue = 0;
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        title: Column(
          children: <Widget>[
            Text(
              widget.article.title,
              style: FontStyles.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                Text(
                  "${widget.article.point} points",
                  style: FontStyles.caption,
                ),
                Text(
                  " · ${DataTransformer.fuzzyDateTime(widget.article.time)}",
                  style: FontStyles.caption,
                ),
                Text(
                  " by ",
                  style: FontStyles.caption,
                ),
                Text(
                  "${widget.article.author}",
                  style: FontStyles.caption.copyWith(
                    color: Colors.brown,
                  ),
                ),
              ],
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          Center(
            child: CupertinoSlidingSegmentedControl(
              groupValue: groupValue,
              children: {0: Text("News"), 1: Text("Comments (${widget.article.commentCount})")},
              onValueChanged: (v) {
                setState(() {
                  groupValue = v;
                  tabController.animateTo(v);
                });
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            height: 2,
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                NewsWebView(
                  url: widget.article.sourceUrl,
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
