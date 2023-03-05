import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// void showResultSnackBar(String message, {bool isSucess = false}) {
//   Fluttertoast.showResultSnackBar(
//       msg: message,
//       gravity: ToastGravity.CENTER,
//       textColor: Colors.white,
//       fontSize: 13,
//       backgroundColor: isSucess ? Colors.green : Colors.black);
// }

SnackBar showResultSnackBar(String? msg, {bool isSucess = true}) {
  return SnackBar(
    elevation: 6.0,
    backgroundColor: isSucess ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          msg!.toString(),
          style: TextStyle(color: isSucess ? Colors.white : Colors.black),
        ),
        isSucess
            ? Icon(
                Icons.done_rounded,
                color: Colors.white,
              )
            : Icon(
                Icons.dangerous,
                color: Colors.black,
              )
      ],
    ),
  );
}
