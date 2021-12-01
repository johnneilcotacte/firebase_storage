import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_flutter_assignment/firebase/sign_in_and_out.dart';
import 'package:new_flutter_assignment/modules/responsive.dart';
import 'package:new_flutter_assignment/providers/const_provider.dart';

class LogOut extends HookWidget {
  const LogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constants = useProvider(constantsProvider);
    final _signIn = useProvider(googleSignInProvider);
    return Container(
      width: (!Responsive.isMobile(context)) ? double.infinity : 130,
      height: (!Responsive.isMobile(context)) ? 50 : 40,
      child: TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
          onPressed: () async {
            _signIn.googleLogOut();
          },
          icon: FaIcon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.black,
            size: 18,
          ),
          label: Text('Log-out',
              style: GoogleFonts.dancingScript(
                  color: constants.kDarkBlackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 20))),
    );
  }
}
