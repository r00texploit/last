import 'package:details/details/models/product.dart';
import 'package:details/screens/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:details/constants.dart';
import 'package:details/models/product.dart';

import 'details_screen.dart';

class Body extends StatelessWidget {
  Body(doc, doc2, doc3);

  // const Body(doc, {
  //   Product? product,
  //   super.key,
  // });

  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60),
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) => productCard(
                  itemIndex: index,
                  product: products![index],
                  press: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => DetailsScreen(
                    //         product: products[index]1
                    //       ),
                    //     ));
                  },
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
