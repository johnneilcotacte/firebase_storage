import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_assignment/config/routes.dart';
import 'package:new_flutter_assignment/models/screen_argument.dart';

class BlogInitialPage extends StatefulWidget {
  @override
  _BlogInitialPageState createState() => _BlogInitialPageState();
}

class _BlogInitialPageState extends State<BlogInitialPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  @override
  void didChangeDependencies() {
    //we don't have to close or unsubscribe SB
    FirebaseAuth.instance.authStateChanges().listen((state) {
      if (state == null) {
        Navigator.pushNamed(context, '${RouteGenerator.blogRoute}',
            arguments: ScreenArguments(null));
      } else {
        Navigator.pushNamed(context, '${RouteGenerator.blogLogInRoute}',
            arguments: ScreenArguments(null));
      }
    });

    super.didChangeDependencies();
  }
}
