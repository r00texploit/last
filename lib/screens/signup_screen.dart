import 'package:details/controller/auth_controller.dart';
import 'package:details/screens/login_screen.dart';
// import 'package:details/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    // final AuthController controller = Get.find();
    return Scaffold(
        // key:controller.formKey2,
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
            color: Color.fromARGB(255, 4, 72, 77),
            gradient: LinearGradient(
              colors: [
                (Color.fromARGB(255, 4, 72, 77)),
                Color.fromARGB(255, 9, 90, 100)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(top: 50),
              //   child: Image.asset(
              //     "images/app_logo.png",
              //     height: 90,
              //     width: 90,
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          )),
        ),
        Form(
            key: controller.formKey2,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      const BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextField(
                    controller: controller.name,
                    cursorColor: const Color.fromARGB(255, 4, 72, 77),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 4, 72, 77),
                      ),
                      hintText: "Full Name",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      const BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextField(
                    controller: controller.email,
                    cursorColor: const Color.fromARGB(255, 4, 72, 77),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 4, 72, 77),
                      ),
                      hintText: "Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffEEEEEE),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextField(
                    controller: controller.number,
                    cursorColor: const Color.fromARGB(255, 4, 72, 77),
                    decoration: const InputDecoration(
                      focusColor: Color.fromARGB(255, 4, 72, 77),
                      icon: Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 4, 72, 77),
                      ),
                      hintText: "Phone Number",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffEEEEEE),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextField(
                    controller: controller.password,
                    cursorColor: const Color.fromARGB(255, 4, 72, 77),
                    decoration: const InputDecoration(
                      focusColor: Color.fromARGB(255, 4, 72, 77),
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color.fromARGB(255, 4, 72, 77),
                      ),
                      hintText: "Enter Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            )),
        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   height: 54,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     color: Colors.grey[200],
        //     boxShadow: [
        //       const BoxShadow(
        //           offset: Offset(0, 10),
        //           blurRadius: 50,
        //           color: Color(0xffEEEEEE)),
        //     ],
        //   ),
        //   child: TextField(
        //     controller: controller.name,
        //     cursorColor: const Color.fromARGB(255, 4, 72, 77),
        //     decoration: const InputDecoration(
        //       icon: Icon(
        //         Icons.person,
        //         color: Color.fromARGB(255, 4, 72, 77),
        //       ),
        //       hintText: "Full Name",
        //       enabledBorder: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //     ),
        //   ),
        // ),

        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   height: 54,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     color: Colors.grey[200],
        //     boxShadow: [
        //       const BoxShadow(
        //           offset: Offset(0, 10),
        //           blurRadius: 50,
        //           color: Color(0xffEEEEEE)),
        //     ],
        //   ),
        //   child: TextField(
        //     controller: controller.email,
        //     cursorColor: const Color.fromARGB(255, 4, 72, 77),
        //     decoration: const InputDecoration(
        //       icon: Icon(
        //         Icons.email,
        //         color: Color.fromARGB(255, 4, 72, 77),
        //       ),
        //       hintText: "Email",
        //       enabledBorder: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //     ),
        //   ),
        // ),
        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   height: 54,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     color: const Color(0xffEEEEEE),
        //     boxShadow: [
        //       const BoxShadow(
        //           offset: Offset(0, 20),
        //           blurRadius: 100,
        //           color: Color(0xffEEEEEE)),
        //     ],
        //   ),
        //   child: TextField(
        //     controller: controller.number,
        //     cursorColor: const Color.fromARGB(255, 4, 72, 77),
        //     decoration: const InputDecoration(
        //       focusColor: Color.fromARGB(255, 4, 72, 77),
        //       icon: Icon(
        //         Icons.phone,
        //         color: Color.fromARGB(255, 4, 72, 77),
        //       ),
        //       hintText: "Phone Number",
        //       enabledBorder: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //     ),
        //   ),
        // ),
        // Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        //   padding: const EdgeInsets.only(left: 20, right: 20),
        //   height: 54,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     color: const Color(0xffEEEEEE),
        //     boxShadow:const [
        //        BoxShadow(
        //           offset: Offset(0, 20),
        //           blurRadius: 100,
        //           color: Color(0xffEEEEEE)),
        //     ],
        //   ),
        //   child: TextField(
        //     controller: controller.password,
        //     cursorColor: const Color.fromARGB(255, 4, 72, 77),
        //     decoration: const InputDecoration(
        //       focusColor: Color.fromARGB(255, 4, 72, 77),
        //       icon: Icon(
        //         Icons.vpn_key,
        //         color: Color.fromARGB(255, 4, 72, 77),
        //       ),
        //       hintText: "Enter Password",
        //       enabledBorder: InputBorder.none,
        //       focusedBorder: InputBorder.none,
        //     ),
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            controller.register();
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                (Color.fromARGB(255, 4, 72, 77)),
                Color.fromARGB(255, 9, 90, 100)
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[200],
              boxShadow: [
                const BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xffEEEEEE)),
              ],
            ),
            child: const Text(
              "REGISTER",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Have Already Member?  "),
              GestureDetector(
                child: const Text(
                  "Login Now",
                  style: TextStyle(color: Color.fromARGB(255, 4, 72, 77)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Get.to(LoginScreen());
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}
