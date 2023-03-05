import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'color_dot.dart';

class ListOfColors extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    GlobalKey key1 = new GlobalKey();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ColorDot(
           
            fillColor: Color(0xFF80989A),
            isSelected: true, 
          ),
          ColorDot(
           
            fillColor: Color(0xFFFF5200),
          
          ),
          ColorDot(
           
            fillColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
