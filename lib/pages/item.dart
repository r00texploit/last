import 'dart:ui';

import 'package:details/constants.dart';
import 'package:details/controller/auth_controller.dart';
import 'package:details/pages/autiziem.dart';
import 'package:details/pages/edit_center_info.dart';
import 'package:details/pages/reserv_center.dart';
import 'package:details/pages/reservation.dart';
import 'package:details/pages/user_page.dart';
import 'package:details/pages/ptsd.dart';
import 'package:details/pages/slow_learner.dart';
import 'package:details/screens/user/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Items extends StatelessWidget {
  const Items({super.key});
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('Ercchad'),
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
                      Get.to(() => Myreserv());
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
                      "Reservation",
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
                      Get.to(() => EditInfo());
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
                      "Edit Info",
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
