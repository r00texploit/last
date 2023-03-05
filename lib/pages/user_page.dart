import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:details/AdminHome.dart';
import 'package:details/details/screens/product/products_screen.dart';
import 'package:details/pages/art.dart';
import 'package:details/pages/erchad.dart';
// import 'package:details/screens/center/item.dart';
import 'package:details/pages/item.dart';
import 'package:details/pages/show_center_user.dart';
import 'package:details/screens/admin/screens/sign_in_page.dart';
import 'package:details/screens/center.dart';
import 'package:details/screens/login_screen.dart';
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
// import 'package:ss_bottom_navbar/ss_bottom_navbar.dart';

import '../../widget/home app bar.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final items = [
  //   SSBottomNavItem(text: 'Home', iconData: Icons.home),
  //   SSBottomNavItem(text: 'Chat', iconData: Icons.chat),
  //   SSBottomNavItem(text: 'Center', iconData: Icons.local_hospital_outlined),
  // ];
  // SSBottomBarState _state = SSBottomBarState();
  final _isVisible = true;
  int i = 0;
  final _bucket = PageStorageBucket();
  var key1 = Key("1");
  var key2 = Key("3");
  var key3 = Key("3");
  var widgetsList = [
    UserHome(),
    ProductsScreen(),
    Chat(),
  ];

/*  Container(
            color: Colors.blueAccent,
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            )*/
  @override
  Widget build(BuildContext context) {
    // GetBuilder(builder: ,)

    // return GetBuilder<AuthController>(
    // init: AuthController(),
    // builder: (_) {
    // create: (_) => SSBottomBarState(),
    // child: Consumer<SSBottomBarState>(
    // builder: (context, state, _) {

    return Scaffold(
        body: SizedBox(
            child: PageStorage(bucket: _bucket, child: widgetsList[i])),
        // ),
        bottomNavigationBar: BottomNavBar(
          showElevation: true,
          selectedIndex: i,
          onItemSelected: (index) {
            setState(() => i = index);
          },
          items: <BottomNavBarItem>[
            BottomNavBarItem(
              title: 'Home',
              icon: const Icon(Icons.home),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              activeBackgroundColor:Color.fromARGB(255, 4, 72, 77),
            ),
            BottomNavBarItem(
              title: 'Center',
              icon: const Icon(Icons.person),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              activeBackgroundColor: Color.fromARGB(255, 4, 72, 77),
            ),
            BottomNavBarItem(
              title: 'Message',
              icon: const Icon(Icons.chat_bubble),
              inactiveColor: Colors.black,
              activeColor: Colors.white,
              activeBackgroundColor: Color.fromARGB(255, 4, 72, 77),
            ),
            // BottomNavBarItem(
            //   title: 'Settings',
            //   icon: const Icon(Icons.settings),
            //   inactiveColor: Colors.black,
            //   activeColor: Colors.black,
            //   activeBackgroundColor: Colors.yellow.shade300,
            // ),
          ],
        ));
    // }
    // });
  }
//   bottomSheet() => Container(
//   color: Colors.white,
//   child: Column(
//     children: [
//       ListTile(
//         leading: Icon(Icons.camera_alt),
//         title: Text('Use Camera'),
//       ),
//       ListTile(
//         leading: Icon(Icons.photo_library),
//         title: Text('Choose from Gallery'),
//       ),
//       ListTile(
//         leading: Icon(Icons.edit),
//         title: Text('Write a Story'),
//       ),
//     ],
//   ),
// );

  final GlobalKey _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Home',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
    const Text(
      'Search',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
    const Text(
      'Add',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
    const Text(
      'Profile',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
    const Text(
      'Setting',
      style: TextStyle(fontSize: 25, color: Colors.black),
    ),
  ];

  //selection

}

class ItemsUser extends StatelessWidget {
  ItemsUser({super.key});
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      // title: Text('User'),
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
                      Get.to(() => Autiziem());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/autizim.jpg"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Autism",
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
                      Get.to(() => PTSD());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/down.jpg"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Down's syndrome",
                      style: TextStyle(
                        fontSize: 17,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => CartPage()));
                      Get.to(() => SlowLearner());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/slow_learner1.jpg"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Slow learning",
                      style: TextStyle(
                        fontSize: 15,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => CartPage()));
                      Get.to(() => Art());
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      child: Image.asset("assets/image/general.jpg"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "The art of dealing",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff4ac53a5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
    //         ]))
    //   ]))
    // ])));
  }
}

class UserHome extends StatelessWidget {
//   const UserHome({super.key});

//   @override
//   State<UserHome> createState() => _UserHomeState();
// }

// class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HomeAppBer(),
        Container(
          margin: const EdgeInsets.only(top: 30),
          decoration: const BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 2000,
              child: Column(
                children: [
                  //76032
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   margin: const EdgeInsets.symmetric(
                  //       vertical: 20, horizontal: 10),
                  //   child: const Text(
                  //     "User",
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.bold,
                  //       color: Color(0XFF4C53A5),
                  //     ),
                  //   ),
                  // ),
                  ItemsUser(),
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
