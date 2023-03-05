import 'package:details/screens/body.dart';
// import 'package:details/screens/center/body.dart';
import 'package:flutter/material.dart';

import 'package:details/constants.dart';

// import 'components/body.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      // body:  Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: const Text('CENTER'),
      actions: const <Widget>[],
    );
  }
}
