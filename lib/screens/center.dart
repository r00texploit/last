import 'package:details/screens/center2.dart';
import 'package:flutter/material.dart';

import 'package:details/constants.dart';
// import 'package:details/screens/center/center2.dart';

class center extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: kPrimaryColor,
      body:Text(""),// booking(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('booking'),
      actions: <Widget>[
        
      ],
    );
  }
}
