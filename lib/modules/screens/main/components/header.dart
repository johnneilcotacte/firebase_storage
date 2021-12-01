import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_flutter_assignment/providers/const_provider.dart';
import 'package:google_fonts/google_fonts.dart';
/*
class Header extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final constants = useProvider(constantsProvider);
    return Container(
      width: double.infinity,
      color: constants.kDarkBlackColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: constants.kMaxWidth),
              padding: EdgeInsets.all(constants.kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [],
                  ),
                  SizedBox(height: constants.kDefaultPadding * 2),
                  Text(
                    "Welcome to Our Blog",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constants.kDefaultPadding),
                    child: Text(
                      "Stay updated with the newest design and development stories, case studies, \nand insights shared by DesignDK Team.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        height: 1.5,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Learn More",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: constants.kDefaultPadding / 2),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (Responsive.isDesktop(context))
                    SizedBox(height: constants.kDefaultPadding),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/

class Header extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final constants = useProvider(constantsProvider);
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: height * .75,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: constants.kDarkBlackColor,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    image: AssetImage(
                      'assets/images/food.jpg',
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Food Blogs',
                style: GoogleFonts.dancingScript(
                    color: Colors.white, fontSize: 52),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
