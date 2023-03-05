import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:details/screens/center/item.dart';
import 'package:details/pages/item.dart';
import 'package:details/screens/center.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:details/constants.dart';
import 'package:details/controller/auth_controller.dart';
import 'package:details/pages/autiziem.dart';
import 'package:details/pages/user_page.dart';
import 'package:details/pages/ptsd.dart';
import 'package:details/pages/slow_learner.dart';
import 'package:details/screens/user/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/home app bar.dart';

class CenterPage extends StatefulWidget {
  CenterPage({super.key});
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  // void _onItemSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // final _isVisible = true;
  // int i = 0;
  // final _bucket = PageStorageBucket();
  // var key1 = Key("1");
  // var key2 = Key("3");
  // var key3 = Key("3");
  // var widgetsList = [];

/*  Container(
            color: Colors.blueAccent,
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            )*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HomeAppBer(),
          Container(
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 2000,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: const Text(
                        "Center",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF4C53A5),
                        ),
                      ),
                    ),
                    const Items(),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   onTap: _onItemSelected,
      //   height: 70,
      //   color: const Color.fromARGB(255, 4, 72, 77), //const Color(0xff4c53a5),
      //   items: const [
      //     Icon(
      //       Icons.home,
      //       size: 30,
      //       color: Colors.black,
      //     ),
      //     Icon(
      //       Icons.home,
      //       size: 30,
      //       color: Colors.black,
      //     ),
      //     Icon(
      //       Icons.home,
      //       size: 30,
      //       color: Colors.black,
      //     )
      //   ],
      // ),
    );
  }

  // final GlobalKey _bottomNavigationKey = GlobalKey();
  // int _selectedIndex = 0;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   const Text(
  //     'Home',
  //     style: TextStyle(fontSize: 25, color: Colors.black),
  //   ),
  //   const Text(
  //     'Search',
  //     style: TextStyle(fontSize: 25, color: Colors.black),
  //   ),
  //   const Text(
  //     'Add',
  //     style: TextStyle(fontSize: 25, color: Colors.black),
  //   ),
  //   const Text(
  //     'Profile',
  //     style: TextStyle(fontSize: 25, color: Colors.black),
  //   ),
  //   const Text(
  //     'Setting',
  //     style: TextStyle(fontSize: 25, color: Colors.black),
  //   ),
  // ];

  //selection

}

class ItemsCenter extends StatelessWidget {
  ItemsCenter({super.key});
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('Center'),
      actions: <Widget>[
        IconButton(
            onPressed: () {
              AuthController controller = Get.put(AuthController());
              controller.signOut();
            },
            icon: Icon(
              Icons.logout,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // appBar: buildAppBar(),
        // backgroundColor: kPrimaryColor,
        // body: SafeArea(
        //     child: Column(children: <Widget>[
        //   const SizedBox(
        //     height: kDefaultPadding / 2,
        //   ),
        //   Expanded(
        //       child: Stack(children: <Widget>[
        //     Container(
        //         margin: const EdgeInsets.only(top: 30),
        //         decoration: const BoxDecoration(
        //             color: kBackgroundColor,
        //             borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(40),
        //                 topRight: Radius.circular(40))),
        //         child: Column(children: [
        GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        // for (int i = 1; i < 5; i++)
        Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => CartPage()));
                      Get.to(() => center());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/avatar-1.png"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Center Booking",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff4ac53a5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )),
        Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => CartPage()));
                      // Get.to(() => ChooseItems());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/avatar-1.png"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Erchad",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff4ac53a5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )),
        // Container(
        //     padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        //     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           InkWell(
        //             onTap: () {
        //               // Navigator.of(context).push(MaterialPageRoute(
        //               //     builder: (context) => CartPage()));
        //               Get.to(() => SlowLearner());
        //             },
        //             child: Container(
        //               margin: const EdgeInsets.all(10),
        //               height: 120,
        //               width: 120,
        //               child: Image.asset("assets/image/avatar-1.png"),
        //             ),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.only(bottom: 8),
        //             alignment: Alignment.centerLeft,
        //             child: const Text(
        //               "Slow learning",
        //               style: TextStyle(
        //                 fontSize: 15,
        //                 color: Color(0xff4ac53a5),
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     )),
        // Container(
        //     padding: const EdgeInsets.only(
        //         left: 15, right: 15, top: 10),
        //     margin: const EdgeInsets.symmetric(
        //         vertical: 8, horizontal: 10),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 20),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           InkWell(
        //             onTap: () {
        //               // Navigator.of(context).push(MaterialPageRoute(
        //               //     builder: (context) => CartPage()));
        //               Get.to(() => CartPage());
        //             },
        //             child: Container(
        //               margin: const EdgeInsets.all(10),
        //               height: 120,
        //               width: 120,
        //               child: Image.asset(
        //                   "assets/image/avatar-1.png"),
        //             ),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.only(bottom: 8),
        //             alignment: Alignment.centerLeft,
        //             child: const Text(
        //               "twahod",
        //               style: TextStyle(
        //                 fontSize: 18,
        //                 color: Color(0xff4ac53a5),
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     )),
      ],
    );
    //         ]))
    //   ]))
    // ])));
  }
}
