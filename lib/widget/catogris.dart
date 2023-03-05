import 'dart:ui';

import 'package:details/pages/slow_learner.dart';
import 'package:details/screens/Chat/chat_list.dart';
import 'package:details/screens/expantion2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivateTrainer extends StatelessWidget {
  const PrivateTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
                      Get.to(() => ChatListPage());
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
                      "Chats",
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
                      Get.to(() => ExpansionTileCardDemo());
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
                      // Get.to(() => CartPage());
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
                      "Slow learning",
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
                      // Get.to(() => CartPage());
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
      ],
    );
  }
}
