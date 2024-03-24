import 'package:flutter/material.dart';
import 'package:izistock/common/widgets/containers/primary_header_container.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          /// header
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              ///AppBar
              TAppBar(
                  title: Text('Account',
                      style: TextStyle(fontFamily: AutofillHints.birthdayDay)))
            ],
          ))
        ],
      ),
    ));
  }
}
