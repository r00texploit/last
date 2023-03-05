import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int? number;
  String? id, title, email, description, image, department, loc, price;

  Product({this.id, this.price, this.title, this.description, this.image});
  Product.fromMap(DocumentSnapshot? data) {
    id = data!.id;
    title = data["name"];
    email = data["email"];
    number = data["phone"];
    loc = data["location"];
    department = data["department"];
    price = data["price"];
    image = data["image"];
  }
}

// list of products
// // for our demo
List<Product>? products = [];
//   Product(
//     id: 1,
//     price: 56,
//     title: "Classic Leather Arm Chair",
//     image: "assets/images/Item_1.png",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
//   Product(
//     id: 4,
//     price: 68,
//     title: "Poppy Plastic Tub Chair",
//     image: "assets/images/Item_2.png",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
//   Product(
//     id: 9,
//     price: 39,
//     title: "Bar Stool Chair",
//     image: "assets/images/Item_3.png",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
//   ),
// ];
