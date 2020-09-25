import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({Key key, this.url}) : super(key: key);
  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
  }
}
