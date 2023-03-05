import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/details/components/search_box.dart';
import 'package:details/details/constants.dart';
import 'package:details/details/models/product.dart';
import 'package:details/details/screens/details/details_screen.dart';
import 'package:details/models/product.dart';
import 'package:details/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:furniture_app/components/search_box.dart';
// import 'package:furniture_app/constants.dart';
// import 'package:furniture_app/models/product.dart';
// import '../screens/details/details_screen.dart';

import 'category_list.dart';
import 'product_card.dart';

class Body extends StatelessWidget {
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('Center'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons
              .notifications), //SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
        IconButton(
            onPressed: () {
              //
              Get.offAll(LoginScreen());
            },
            icon: Icon(
              Icons.logout,
            ))
      ],
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
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: kDefaultPadding / 2,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('center')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                if (snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                    child: Text('No Available Center',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Product products = Product.fromMap(
                                            snapshot.data!.docs[index]);
                                        return 
                                        ProductCard(
                                          itemIndex: index,
                                          product: products,
                                          press: () {
                                            // Product products = Product.fromMap(
                                            //     snapshot.data!.docs[index]);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen(
                                                  name: products,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });
                                }
                              }
                            }))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
