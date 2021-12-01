import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_flutter_assignment/firebase/sign_in_and_out.dart';

//run in flutter run -d chrome --web-port 5000

class SignIn extends HookWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signIn = useProvider(googleSignInProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              _signIn.googleLogIn();
              //_handleSignIn();
            },
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text('Sign Up with Google'),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
          )
        ],
      ),
    );
  }
}
