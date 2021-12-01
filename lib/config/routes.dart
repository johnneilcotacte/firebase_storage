import 'package:flutter/material.dart';
import 'package:new_flutter_assignment/modules/blog_editor/blog_editor.dart';
import 'package:new_flutter_assignment/modules/bonus/blog_initialpage.dart';
import 'package:new_flutter_assignment/modules/bonus/signin_blogpage.dart';
import 'package:new_flutter_assignment/modules/screens/blog_fullscreen/blogfullscreen.dart';
import 'package:new_flutter_assignment/modules/screens/graphql_screen/graphql_characters.dart';
import 'package:new_flutter_assignment/modules/screens/main/main_screen_blogs.dart';
import 'package:new_flutter_assignment/modules/screens/upload_file/upload_file.dart';

class RouteGenerator {
  static const String bloginitialRoute = '/blogs';
  static const String blogLogInRoute = '/blogs/log-in';
  static const String blogRoute = '/blogs/home';
  static const String composeblogRoute = '/blogs/compose';
  static const String editblogRoute = '/blogs/edit';
  static const String viewblogRoute = '/blogs/view';
  static const String graphqlRoute = '/graphql';
  static const String bonusRoute = '/bonus';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case bloginitialRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: BlogInitialPage()),
          settings: settings,
        );
      case blogLogInRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: SignIn()),
          settings: settings,
        );
      case blogRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: MainScreenBlogs()),
          settings: settings,
        );
      case composeblogRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: BlogEditor()),
          settings: settings,
        );
      case viewblogRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: FullScreen()),
          settings: settings,
        );
      case editblogRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: BlogEditor()),
          settings: settings,
        );
      case graphqlRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: GraphqlPage()),
          settings: settings,
        );
      case bonusRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: BonusPage()),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(
              child: Text('Page not found!'),
            )));
  }
}

class _RouteHandler extends StatelessWidget {
  final Widget routeWidget;

  const _RouteHandler({Key? key, required this.routeWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return routeWidget;
  }
}
