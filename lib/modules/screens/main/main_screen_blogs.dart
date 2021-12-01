import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_flutter_assignment/modules/appbar/custom_appbar.dart';
import 'package:new_flutter_assignment/modules/appbar/custom_drawer.dart';
import 'package:new_flutter_assignment/modules/responsive.dart';
import 'package:new_flutter_assignment/modules/screens/home/components/compose.dart';
import 'package:new_flutter_assignment/modules/screens/home/home_screen.dart';
import 'package:new_flutter_assignment/providers/const_provider.dart';
import 'components/header.dart';

class MainScreenBlogs extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _constants = useProvider(constantsProvider);
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomEndDrawer(),
      floatingActionButton: (Responsive.isMobile(context)) ? Compose() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              padding: EdgeInsets.all(_constants.kDefaultPadding),
              constraints: BoxConstraints(maxWidth: _constants.kMaxWidth),
              child: SafeArea(child: HomeScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
