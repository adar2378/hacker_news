import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hacker_news/common/widgets/listview_loader.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/modules/news_module/adapters/comment_adapter.dart';
import 'package:hacker_news/modules/news_module/blocs/comment_bloc/comment_bloc.dart';
import 'package:hacker_news/routes/routes.dart';
import 'package:hacker_news/styles/font_styles.dart';

class Comments extends StatefulWidget {
  final List<int> comments;

  const Comments({Key key, this.comments}) : super(key: key);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> with AutomaticKeepAliveClientMixin {
  CommentBloc commentBloc;
  @override
  void initState() {
    commentBloc = CommentBloc()..add(CommentFetch(widget.comments));
    super.initState();
  }

  @override
  void dispose() {
    commentBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CommentBloc, CommentState>(
      cubit: commentBloc,
      builder: (context, state) {
        if (state is CommentLoading)
          return ListViewLoader();
        else if (state is CommentData && state.hasData) {
          return Scrollbar(
            child: ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];
                  return ListTile(
                    onTap: () {
                      if (comment.childComments != null && comment.childComments.length > 0)
                        Navigator.pushNamed(context, Routes.moreComments, arguments: comment);
                      else
                        return null;
                    },
                    leading: Icon(Icons.comment),
                    title: Row(
                      children: <Widget>[
                        Text(
                          (comment.author ?? "") + ", ",
                          style: FontStyles.caption.copyWith(
                            color: Colors.brown,
                          ),
                        ),
                        Text(comment.time == null ? "" : DataTransformer.fuzzyDateTime(comment.time),
                            style: FontStyles.caption),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HtmlWidget(
                          comment.text ?? "",
                          textStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        if (comment.childComments != null && comment.childComments.length > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              comment.childComments.length.toString() + " replies",
                              style: Theme.of(context).textTheme.button.copyWith(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
          );
        } else
          return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
