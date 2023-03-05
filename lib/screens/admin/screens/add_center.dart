import 'package:details/details/constants.dart';
import 'package:details/screens/admin/controller/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:details/screens/admin/widgets/custom_textfield.dart';

// import '../controller/add_travel_controller.dart';

class Addcenter extends StatelessWidget {
  const Addcenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Add center'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
  }
}

Widget form(context) {
  TextEditingController n = TextEditingController();
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<AddDataController>(
      init: AddDataController(),
      builder: (_) {
        return Form(
          key: _.formKey,
          child: Container(
              // height: height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(46),
                  topRight: Radius.circular(46),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      // CustomTextField(
                      //   controller: _.no,
                      //   validator: (value) {
                      //     return _.validateAddress(value!);
                      //   },
                      //   lable: 'center number',
                      //   icon: const Icon(Icons.numbers),
                      //   input: TextInputType.number,
                      // ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _.name,
                        validator: (value) {
                          return _.validateAddress(value!);
                        },
                        lable: 'center name',
                        icon: const Icon(Icons.person),
                        input: TextInputType.text,
                      ),
                      const SizedBox(height: 20),
                      // CustomTextField(
                      //     controller: _.dep,
                      //     validator: (value) {
                      //       return _.validateAddress(value!);
                      //     },
                      //     lable: 'center department',
                      //     icon: const Icon(Icons.accessibility),
                      //     input: TextInputType.text),
                      CustomTextField(
                          controller: _.email,
                          validator: (value) {
                            return _.validateAddress(value!);
                          },
                          lable: 'center email',
                          icon: const Icon(Icons.email),
                          input: TextInputType.text),
                      CustomTextField(
                          controller: _.password,
                          validator: (value) {
                            return _.validateAddress(value!);
                          },
                          lable: 'center password',
                          icon: const Icon(Icons.password),
                          input: TextInputType.text),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                            onPressed: () async {
                              _.addcenter();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(
                                      top: height / 55,
                                      bottom: height / 55,
                                      left: width / 10,
                                      right: width / 10)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(19, 26, 44, 1.0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: const BorderSide(
                                          color: Color.fromRGBO(
                                              19, 26, 44, 1.0)))),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 16),
                            )),
                      )
                    ],
                  ),
                ],
              )),
        );
      });
}
