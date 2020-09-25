import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hacker_news/common/screens/home_screen.dart';
import 'package:hacker_news/common/screens/unknown_screen.dart';
import 'package:hacker_news/modules/news_module/screens/news_details_screen.dart';
import 'package:hacker_news/routes/routes.dart';

class RouteHelper {
  static Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return _buildRoute(settings, HomeScreen());
        break;
      case Routes.newsDetails:
        return _buildRoute(
          settings,
          NewsDetailsScreen(
            article: settings.arguments,
          ),
        );
        break;
      default:
        return _buildRoute(settings, UnknownScreen());
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return _buildRoute(settings, UnknownScreen());
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      maintainState: true,
      builder: (BuildContext context) => builder,
    );
  }
}
