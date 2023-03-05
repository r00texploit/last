import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/chat/new_chat.dart';
import 'package:details/chat/room.dart';
import 'package:details/pages/user_page.dart';
import 'package:details/pages/home%20page.dart';
import 'package:details/screens/Chat/chat_list.dart';
import 'package:details/screens/center.dart';
import 'package:details/pages/item.dart';
import 'package:details/screens/center/home.dart';
// import 'package:details/screens/user/chat.dart';
import 'package:details/screens/expantion.dart';
import 'package:details/screens/login_screen.dart';
import 'package:details/screens/signup_screen.dart';
import 'package:details/screens/user/chat_training.dart';
import 'package:details/widget/catogris.dart';
import 'package:details/widget/loading.dart';
import 'package:details/widget/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'package:details/screens/admin/screens/home.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  TextEditingController? email,
      name,
      password,
      Rpassword,
      repassword,
      dep,
      number,
      loc,
      pri;

  bool ob = false;
  bool obscureTextLogin = true;
  bool obscureTextSignup = true;
  bool obscureTextSignupConfirm = true;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  late Widget route;
  @override
  void onReady() {
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onReady();
  }

  @override
  void onInit() {
    email = TextEditingController();
    dep = TextEditingController();

    password = TextEditingController();
    Rpassword = TextEditingController();
    repassword = TextEditingController();
    number = TextEditingController();
    name = TextEditingController();
    pri = TextEditingController();
    loc = TextEditingController();

    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    super.onInit();
  }

  var ipev = 0;

  // String? get user_ch => _user.value!.email;
  _initialScreen(User? user) async {
    var admin = await FirebaseFirestore.instance.collection('admin').get();
    var users = await FirebaseFirestore.instance.collection('user').get();
    var train = await FirebaseFirestore.instance.collection('training').get();
    var center = await FirebaseFirestore.instance.collection('center').get();
    // var train = await FirebaseFirestore.instance.collection('training').get();

    if (user != null) {
      for (var e in admin.docs) {
        if (e["email"] == user.email) {
          // route = LoginScreen();
          ipev = 1;
          update();
        }
      }
    } else if (ipev == 0) {
      for (var e in users.docs) {
        if (e["email"] == user!.email) {
          ipev = 2;
          update();
        }
      }
      // route = const HomeScreen();

    } else if (ipev == 0) {
      for (var e in train.docs) {
        if (e["email"] == user!.email) {
          ipev = 3;
          update();
        }
      }
      // route = const HomeScreen();
    } else if (ipev == 0) {
      for (var e in center.docs) {
        if (e["email"] == user!.email) {
          ipev = 4;
          update();
        }
      }
      // route = const HomeScreen();
    }
    var routes = [
      LoginScreen(),
      AdminHome(),
      UserPage(),
      PrivateTrainer(),
      CenterPage()
    ];
    for (int i = 0; i < 4; i++) {
      if (i == ipev) {
        route = routes[i];
        update();
      }
    }
  }

  toggleLogin() {
    obscureTextLogin = !obscureTextLogin;

    update();
  }

  toggleSignup() {
    obscureTextSignup = !obscureTextSignup;
    update();
  }

  toggleSignupConfirm() {
    obscureTextSignupConfirm = !obscureTextSignupConfirm;
    update();
  }

  String? validate(String value) {
    if (value.isEmpty) {
      return "please enter your name";
    }

    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return "please enter your Phone";
    }
    if (value.length < 10) {
      return "Phone length must be more than 10";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty) {
      return "please enter your email";
    }

    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    return null;
  }

  String? validateRePassword(String value) {
    if (value.isEmpty) {
      return "please enter your password";
    }
    if (value.length < 6) {
      return "password length must be more than 6 ";
    }
    if (password!.text != value) {
      return "Password not matched ";
    }
    return null;
  }

  changeOb() {
    ob = !ob;
    update(['password']);
  }

  void signOut() async {
    Get.dialog(AlertDialog(
      content: const Text('Are you are sure to log out'),
      actions: [
        TextButton(
            onPressed: () async {
              await auth
                  .signOut()
                  .then((value) => Get.offAll(() => LoginScreen()));
            },
            child: const Text('yes')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('back'))
      ],
    ));
  }

  void register() async {
    if (formKey2.currentState!.validate()) {
      try {
        // SmartDialog.showLoading();
        showdilog();
        final credential = await auth.createUserWithEmailAndPassword(
            email: email!.text, password: password!.text);
        credential.user!.updateDisplayName(name!.text);
        await credential.user!.reload();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': name!.text,
          'email': email!.text,
          'number': int.tryParse(number!.text),
          'uid': credential.user!.uid,
        });
        // Get.back();
        email!.clear();
        password!.clear();
        showbar("About User", "User message", "User Created!!", true);
        Get.offAll(UserPage());
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About User", "User message", e.toString(), false);
      }
    }
  }

  void updateCenterInfo() async {
    if (formKey2.currentState!.validate()) {
      try {
        // SmartDialog.showLoading();
        var uid = FirebaseAuth.instance.currentUser!.uid;
        var cs = FirebaseFirestore.instance.collection('center').get();

        log(uid);
        FirebaseFirestore.instance.collection("center").doc(uid).update({
          'name': name!.text,
          'location': loc!.text,
          'price': pri!.text,
          'phone': int.tryParse(number!.text),
          'department': dep!.text,

          // 'uid': credential.user!.uid,
        });

        Get.back();
        email!.clear();
        password!.clear();
        showbar("About Center", "Center message", "Center Created!!", true);
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About Center", "Center message", e.toString(), false);
      }
    }
  }

  void booking(doc, bookID) async {
    if (formKey2.currentState!.validate()) {
      // var centerName = TextEditingController();
      // centerName!.text = doc;
      try {
        showdilog();
        await FirebaseFirestore.instance.collection('booking').doc().set({
          'name': name!.text,
          'age': email!.text,
          'email': bookID,
          'phone': int.tryParse(number!.text),
          'department': dep!.text,
          'centerName': doc,
          'approve': 0,
        });
        Get.back();
        email!.clear();
        password!.clear();
        showbar("About booking", "booking message", "booking Created!!", true);
      } on FirebaseAuthException catch (e) {
        Get.back();
        showbar("About booking", "booking message", e.toString(), false);
      }
    }
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        showdilog();
        await auth.signInWithEmailAndPassword(
            email: email!.text, password: password!.text);
        var ch = await FirebaseFirestore.instance
            .collection('admin')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email!.text)
            .get();
        var ch2 = await FirebaseFirestore.instance
            .collection('users')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email!.text)
            .get();
        var ch3 = await FirebaseFirestore.instance
            .collection('training')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email!.text)
            .get();
        var ch4 = await FirebaseFirestore.instance
            .collection('center')
            // .where('aprrov', isEqualTo: 1)
            // .where('email', isEqualTo: email!.text)
            .get();
        int approve = 0;
        for (var element in ch.docs) {
          if (element['email'] == email!.text) {
            approve = 1;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        for (var element in ch2.docs) {
          if (element['email'] == email!.text) {
            approve = 2;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        for (var element in ch3.docs) {
          if (element['email'] == email!.text) {
            approve = 3;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        for (var element in ch4.docs) {
          if (element['email'] == email!.text) {
            approve = 4;
            // Get.back();
            // Get.offAll(() => const HomeScreen());
          }
        }
        if (approve == 1) {
          email!.clear();
          password!.clear();
          Get.back();
          Get.offAll(() => AdminHome());
        }
        if (approve == 2) {
          email!.clear();
          password!.clear();
          Get.back();
          Get.offAll(() => UserPage());
        }
        if (approve == 3) {
          email!.clear();
          password!.clear();
          Get.back();
          Get.offAll(() => ChatTraining());
        }
        if (approve == 4) {
          email!.clear();
          password!.clear();
          Get.back();
          Get.offAll(() => CenterPage());
        }
        if (approve == 0) {
          Get.back();
          showbar("About Login", "Login message", 'You dont have a permission',
              false);
        }
        // if (ch.docs.isNotEmpty) {
        //   Get.back();
        //   Get.offAll(() => const HomeScreen());
        // } else {

        // }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          showbar("About Login", "Login message", "weak password", false);
        }
        if (e.code == 'email-already-in-use') {
          Get.back();
          showbar(
              "About Login", "Login message", 'email-already-in-use', false);
        }
        if (e.code == 'user-not-found') {
          Get.back();
          showbar("About Login", "Login message", ' user-not-found', false);
        }
        if (e.code == 'wrong-password') {
          Get.back();
          showbar("About Login", "Login message", ' wrong-password', false);
        } else {
          Get.back();
          showbar("About Login", "Login message", e.toString(), false);
        }
      }
    }
  }
}
