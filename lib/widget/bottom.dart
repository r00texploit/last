import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget custombar(context) {
  return CurvedNavigationBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    onTap: (index) {},
    height: 70,
    color: const Color.fromARGB(255, 4, 72, 77), //const Color(0xff4c53a5),
    items: const [
      Icon(
        Icons.home,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.home,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.home,
        size: 30,
        color: Colors.black,
      )
    ],
  );
}
