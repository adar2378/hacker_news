import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({Key key, this.url}) : super(key: key);
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> with AutomaticKeepAliveClientMixin {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool loading = false;
  bool shown = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        if (loading)
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(HNColors.primaryColor),
          ),
        Expanded(
          child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageStarted: (String url) {
              setState(() {
                loading = true;
              });
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              setState(() {
                loading = false;
              });
              print('Page finished loading: $url');
            },
            onWebResourceError: (error) {
              if (!shown)
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Having trouble loading the URL"),
                  behavior: SnackBarBehavior.floating,
                ));
              setState(() {
                if (!shown) shown = true;
                loading = false;
              });
            },
            gestureNavigationEnabled: true,
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
