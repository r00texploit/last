import 'package:details/details/constants.dart';
import 'package:details/details/models/product.dart';
import 'package:details/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:furniture_app/constants.dart';
// import 'package:furniture_app/models/product.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  // final Product? product;
  Product? name;
  DetailsScreen({Key? key, /*this.product,*/ this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(),
      body: Body(
        name: name,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: (() {
          Get.back();
        }),
      ),
      // elevation: 0,
      // centerTitle: false,
      // title: Text('User'),
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons
      //         .notifications), //SvgPicture.asset("assets/icons/notification.svg"),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //       onPressed: () {
      //         //
      //         Get.offAll(LoginScreen());
      //       },
      //       icon: Icon(
      //         Icons.logout,
      //       ))
      // ],
      // actions: <Widget>[
      //   // IconButton(
      //   //     onPressed: () {
      //   //       //
      //   //       Get.offAll(LoginScreen());
      //   //     },
      //   //     icon: Icon(
      //   //       Icons.logout,
      //   //     ))
      // ],
    );
  }
}
