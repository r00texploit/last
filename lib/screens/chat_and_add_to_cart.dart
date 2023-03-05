import 'package:details/screens/center.dart';
import 'package:flutter/material.dart';
// import 'package:details/screens/center/center.dart';

import '../../../constants.dart';

class ChatAndAddToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => center(),
            ));
      },
      child: Container(
        // width: 150,

        margin: EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFCBF1E),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: kDefaultPadding / 2),
            Text(
              "booking",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            // it will cover all available spaces
            Spacer(),

          ],
        ),
        
      ),
    );
  }
}
