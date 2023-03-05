import 'package:details/screens/body.dart';
import 'package:flutter/material.dart';
import 'package:details/constants.dart';
import 'package:details/models/product.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:details/screens/details/componants/body.dart';

class DetailsScreen extends StatelessWidget {
  String? doc, doc2, doc3;
  DetailsScreen(doc, doc2, doc3);

  // var product;

  // DetailsScreen({});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(doc, doc2, doc3),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Colors.black12,
          ),
          child: IconButton(
            // Icons.call,
            // size: 25,
            color: Colors.white,
            onPressed: () {
              // var teluri = Uri.parse(widget.tel.toString());
              launchUrlString("tel:0123456789");
            },
            icon: const Icon(Icons.call, size: 25),
          ),
        ),
      ],
    );
  }
}
