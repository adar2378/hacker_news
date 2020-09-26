import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/common/widgets/listview_loader.dart';
import 'package:hacker_news/common/widgets/not_found.dart';
import 'package:hacker_news/modules/news_module/blocs/news_bloc/news_bloc.dart';
import 'package:hacker_news/modules/news_module/widgets/news_tile.dart';
import 'package:hacker_news/routes/routes.dart';
import 'package:hacker_news/styles/font_styles.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  NewsBloc newsBloc;

  @override
  void initState() {
    newsBloc = NewsBloc()..add(NewsFetchTopStroies());
    super.initState();
  }

  @override
  void dispose() {
    newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(
          height: 56,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Top Stories",
            style: FontStyles.title2,
          ),
        ),
        BlocBuilder<NewsBloc, NewsState>(
          cubit: newsBloc,
          builder: (context, state) {
            if (state is NewsStateLoading) {
              return ListViewLoader();
            } else if (state is NewsStateData && state.hasData) {
              return ListView.separated(
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.articles.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 2,
                    );
                  },
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.newsDetails, arguments: article);
                      },
                      child: NewsTile(
                        article: article,
                        index: index,
                      ),
                    );
                  });
            } else if ((state is NewsStateData && !state.hasData) || state is NewsStateError) {
              return Container(
                height: MediaQuery.of(context).size.height - 160,
                child: NotFoundWidget(
                  message: (state is NewsStateData && !state.hasData) ? "No news found!" : "Sorry, failed to load",
                ),
              );
            } else
              return Container();
          },
        ),
      ],
    );
  }
}
