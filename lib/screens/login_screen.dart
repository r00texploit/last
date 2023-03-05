// import 'package:details/chat.dart';
import 'package:details/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // return initWidget();
    return Scaffold(
      // body: GetBuilder<AuthController>(
      //   // init: AuthController(),
      //   builder: (controller) {
      // return
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
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
                //     "assets/image/user.png",
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              ],
            )),
          ),
          Form(
            key: controller.formKey,
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
                    boxShadow: const [
                      BoxShadow(
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
                      hintText: "Enter Email",
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Write Click Listener Code Here
                    },
                    child: const Text("Forget Password?"),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   padding: const EdgeInsets.only(left: 20, right: 20),
          //   height: 54,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     color: const Color(0xffEEEEEE),
          //     boxShadow: const [
          //       BoxShadow(
          //           offset: Offset(0, 20),
          //           blurRadius: 100,
          //           color: Color(0xffEEEEEE)),
          //     ],
          //   ),
          //   child: TextField(
          //     controller: controller.password,
          //     cursorColor: Color.fromARGB(255, 4, 72, 77),
          //     decoration: InputDecoration(
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
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          //   alignment: Alignment.centerRight,
          //   child: GestureDetector(
          //     onTap: () {
          //       // Write Click Listener Code Here
          //     },
          //     child: const Text("Forget Password?"),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              // AuthController authController = Get.put(AuthController());
              controller.login();
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
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't Have Any Account?  "),
                GestureDetector(
                  child: const Text(
                    "Register Now",
                    style: TextStyle(color: Color.fromARGB(255, 4, 72, 77)),
                  ),
                  onTap: () {
                    // Write Tap Code Here.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                )
              ],
            ),
          )
        ],
      )),
      // })
    );
  }
}
//   Widget initWidget() {
//     // final AuthController controller = Get.put(AuthController());
//     return Scaffold(
//         body: GetBuilder<AuthController>(
//             // init: AuthController(),
//             builder: (controller) {
//               return SingleChildScrollView(
//                   child: Column(
//                 children: [
//                   Container(
//                     height: 300,
//                     decoration: const BoxDecoration(
//                       borderRadius:
//                           BorderRadius.only(bottomLeft: Radius.circular(90)),
//                       color: Color.fromARGB(255, 4, 72, 77),
//                       gradient: LinearGradient(
//                         colors: [
//                           (Color.fromARGB(255, 4, 72, 77)),
//                           Color.fromARGB(255, 9, 90, 100)
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child: Center(
//                         child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 50),
//                           child: Image.asset(
//                             "assets/image/user.png",
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(right: 20, top: 20),
//                           alignment: Alignment.bottomRight,
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(fontSize: 20, color: Colors.white),
//                           ),
//                         )
//                       ],
//                     )),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     height: 54,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.grey[200],
//                       boxShadow: const [
//                         BoxShadow(
//                             offset: Offset(0, 10),
//                             blurRadius: 50,
//                             color: Color(0xffEEEEEE)),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: controller.email,
//                       cursorColor: Color.fromARGB(255, 4, 72, 77),
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.email,
//                           color: Color.fromARGB(255, 4, 72, 77),
//                         ),
//                         hintText: "Enter Email",
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     height: 54,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: const Color(0xffEEEEEE),
//                       boxShadow: const [
//                         BoxShadow(
//                             offset: Offset(0, 20),
//                             blurRadius: 100,
//                             color: Color(0xffEEEEEE)),
//                       ],
//                     ),
//                     child: TextField(
//                       controller: controller.password,
//                       cursorColor: Color.fromARGB(255, 4, 72, 77),
//                       decoration: InputDecoration(
//                         focusColor: Color.fromARGB(255, 4, 72, 77),
//                         icon: Icon(
//                           Icons.vpn_key,
//                           color: Color.fromARGB(255, 4, 72, 77),
//                         ),
//                         hintText: "Enter Password",
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 20),
//                     alignment: Alignment.centerRight,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Write Click Listener Code Here
//                       },
//                       child: const Text("Forget Password?"),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // AuthController authController = Get.put(AuthController());
//                       controller.login();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin:
//                           const EdgeInsets.only(left: 20, right: 20, top: 70),
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       height: 54,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [
//                               (Color.fromARGB(255, 4, 72, 77)),
//                               Color.fromARGB(255, 9, 90, 100)
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight),
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.grey[200],
//                         boxShadow: const [
//                           BoxShadow(
//                               offset: Offset(0, 10),
//                               blurRadius: 50,
//                               color: Color(0xffEEEEEE)),
//                         ],
//                       ),
//                       child: const Text(
//                         "LOGIN",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't Have Any Account?  "),
//                         GestureDetector(
//                           child: const Text(
//                             "Register Now",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 4, 72, 77)),
//                           ),
//                           onTap: () {
//                             // Write Tap Code Here.
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SignUpScreen(),
//                                 ));
//                           },
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ));
//             }));
//   }
// }
