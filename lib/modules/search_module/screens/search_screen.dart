import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/common/widgets/listview_loader.dart';
import 'package:hacker_news/common/widgets/not_found.dart';
import 'package:hacker_news/modules/news_module/widgets/news_tile.dart';
import 'package:hacker_news/modules/search_module/blocs/search_bloc/search_bloc.dart';
import 'package:hacker_news/routes/routes.dart';
import 'package:hacker_news/styles/font_styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController;
  SearchBloc searchBloc;
  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    searchController = TextEditingController()..addListener(listener);
    searchBloc = SearchBloc();
    super.initState();
  }

  @override
  void dispose() {
    searchBloc?.close();
    focusNode?.dispose();
    searchController?.dispose();
    super.dispose();
  }

  void listener() {
    if (focusNode.hasFocus && searchController.value.text.length > 0) {
      searchBloc.add(SearchFetch(searchController.value.text));
    }
  }

  @override
  void didChangeDependencies() {
    print(MediaQuery.of(context).padding.bottom);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (focusNode.hasFocus) focusNode.unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 36,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Search Stories",
                style: FontStyles.title2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                focusNode: focusNode,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Type here...",
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Divider(
              height: 2,
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                cubit: searchBloc,
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return ListViewLoader();
                  } else if (state is SearchData && state.hasData) {
                    return ListView(
                      padding: EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Search Results",
                            style: FontStyles.title,
                          ),
                        ),
                        ListView.separated(
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
                                if (focusNode.hasFocus) focusNode.unfocus();
                                Navigator.pushNamed(context, Routes.newsDetails, arguments: article);
                              },
                              child: NewsTile(
                                article: article,
                                index: index,
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else if (state is SearchData && !state.hasData) {
                    return NotFoundWidget(
                      message: "No stories found!",
                    );
                  } else if (state is SearchInitial) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            size: 48,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Search result will appear here!",
                            style: FontStyles.caption,
                          )
                        ],
                      ),
                    );
                  } else
                    return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
