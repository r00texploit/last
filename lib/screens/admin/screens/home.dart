import 'package:details/details/constants.dart';
import 'package:details/screens/admin/screens/Trainer_page.dart';
import 'package:details/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:details/controller/auth_controller.dart';
import 'package:details/screens/admin/screens/add-Trainer.dart';
import 'package:details/screens/admin/screens/add_department.dart';
import 'package:details/screens/admin/screens/add_center.dart';
import 'package:details/screens/admin/screens/show_center.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('Admin'),
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

  AuthController auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.add, size: 30, color: Colors.white),
                  title: 'Add Center',
                  nav: Addcenter(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Show Center',
                  nav: Showcenter(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Add Trainer',
                  nav: AddTrainer(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Trainer',
                  nav: TrainerPage(),
                ),
                //  Card_d(
                //   icon: Icon(Icons.person, size: 30, color: Colors.white),
                //   title: 'Add Department',
                //   nav: AddDepartment(),
                // ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: kPrimaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
