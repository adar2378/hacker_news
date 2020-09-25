import 'package:flutter/material.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/modules/news_module/adapters/comment_adapter.dart';
import 'package:hacker_news/styles/font_styles.dart';

import 'comments.dart';

class MoreComments extends StatelessWidget {
  final CommentAdapter comment;

  const MoreComments({Key key, this.comment}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              comment.text,
              style: FontStyles.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                Text(
                  "${DataTransformer.fuzzyDateTime(comment.time)}",
                  style: FontStyles.caption,
                ),
                Text(
                  " by ",
                  style: FontStyles.caption,
                ),
                Text(
                  "${comment.author}",
                  style: FontStyles.caption.copyWith(
                    color: Colors.brown.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Replies",
              style: FontStyles.title,
            ),
          ),
          Expanded(
            child: Comments(
              comments: comment.childComments,
            ),
          ),
        ],
      ),
    );
  }
}
