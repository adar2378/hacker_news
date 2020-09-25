import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/modules/news_module/blocs/news_bloc/news_bloc.dart';
import 'package:hacker_news/modules/news_module/widgets/news_tile.dart';

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
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Top News",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        BlocBuilder<NewsBloc, NewsState>(
          cubit: newsBloc,
          builder: (context, state) {
            if (state is NewsStateLoading) {
              return CircularProgressIndicator();
            } else if (state is NewsStateData && state.hasData) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.articles.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return NewsTile(
                      article: article,
                    );
                  });
            } else
              return Container();
          },
        ),
      ],
    );
  }
}
