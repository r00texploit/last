import 'package:details/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:details/constants.dart';
import 'package:get/get.dart';

class booking extends StatelessWidget {
  // final AuthController controller = Get.put(AuthController());
  String? doc;
  String? email;
  booking(this.doc, this.email);

  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
              child: Column(children: <Widget>[
            // const SizedBox(
            //   height: kDefaultPadding / 2,
            // ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: controller.formKey2,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 70),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                    controller: controller.name,
                                    cursorColor:
                                        const Color.fromARGB(255, 4, 72, 77),
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.child_care_outlined,
                                        color: Color.fromARGB(255, 4, 72, 77),
                                      ),
                                      hintText: "Child Name",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                    cursorColor:
                                        const Color.fromARGB(255, 4, 72, 77),
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.child_care_outlined,
                                        color: Color.fromARGB(255, 4, 72, 77),
                                      ),
                                      hintText: "age",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                    cursorColor:
                                        const Color.fromARGB(255, 4, 72, 77),
                                    decoration: const InputDecoration(
                                      focusColor:
                                          Color.fromARGB(255, 4, 72, 77),
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
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                    controller: controller.dep,
                                    cursorColor:
                                        const Color.fromARGB(255, 4, 72, 77),
                                    decoration: const InputDecoration(
                                      focusColor:
                                          Color.fromARGB(255, 4, 72, 77),
                                      icon: Icon(
                                        Icons.vpn_key,
                                        color: Color.fromARGB(255, 4, 72, 77),
                                      ),
                                      hintText: "Enter Department",
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.booking(doc, email);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 70),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      (Color.fromARGB(255, 4, 72, 77)),
                                      Color.fromARGB(255, 9, 90, 100)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
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
                                "Booking",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ]));
          // );
        });
  }
}
