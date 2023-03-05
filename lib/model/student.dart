import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? id;
  int? number;
  String? ptstate;

  // int? price;

  Student({
    this.id,
    required this.ptstate,
    required this.number,
    // required this.price,
  });

  Student.fromMap(DocumentSnapshot data) {
    id = data.id;
    number = data["No"];
    ptstate = data["ptstate"];

    // price = data["price"];
  }
}
