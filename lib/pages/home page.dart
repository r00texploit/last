import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:details/widget/bottom.dart';
import 'package:details/widget/catogris.dart';
import 'package:details/widget/home%20app%20bar.dart';
import 'package:flutter/material.dart';

class ErchadPage extends StatelessWidget {
  const ErchadPage({super.key});

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
                        "ERCHAD",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF4C53A5),
                        ),
                      ),
                    ),
                    // ItemsWdget(),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
      bottomNavigationBar: custombar(context),
    );
  }
}
