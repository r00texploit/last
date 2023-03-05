import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/pages/center_booking.dart';
import 'package:details/screens/center.dart';
import 'package:details/widget/home%20app%20bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:details/screens/admin/widgets/custom_button.dart';
import 'package:details/screens/admin/widgets/loading.dart';
import 'package:details/screens/admin/widgets/snackbar.dart';

class Myreserv extends StatefulWidget {
  const Myreserv({Key? key}) : super(key: key);

  @override
  State<Myreserv> createState() => _MyreservState();
}

class _MyreservState extends State<Myreserv> {
  bool approve = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 72, 77),
        title: Text('All Reservation'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('booking')
                  .where("email",
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No A vailable requset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 5,
                            // color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row(
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Text(
                                //         "center name: ${snapshot.data!.docs[index]['name']}",
                                //         style: const TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //     IconButton(
                                //         onPressed: () {
                                //           change(snapshot.data!.docs[index].id,
                                //               'name');
                                //         },
                                //         icon: Icon(Icons.edit))
                                //   ],
                                // ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "user name:  ${snapshot.data!.docs[index]['name']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       change(snapshot.data!.docs[index].id,
                                    //           'email');
                                    //     },
                                    //     icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'user phone: ${snapshot.data!.docs[index]['phone']}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () {
                                    //       change(snapshot.data!.docs[index].id,
                                    //           'password');
                                    //     },
                                    //     icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: CustomTextButton(
                                          lable: 'cancel',
                                          ontap: () async {
                                            setState(() {
                                              showdilog();
                                            });
                                            try {
                                              var res = await FirebaseFirestore
                                                  .instance
                                                  .collection('booking')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .delete();

                                              setState(() {
                                                Get.back();
                                                showbar(
                                                    'updated booking',
                                                    'subtitle',
                                                    'updated booking',
                                                    true);
                                              });
                                            } catch (e) {
                                              setState(() {
                                                Get.back();
                                                showbar(
                                                    'updated booking',
                                                    'subtitle',
                                                    e.toString(),
                                                    false);
                                              });
                                            }
                                          },
                                          color: Colors.red),
                                    ),
                                    Center(
                                      child: CustomTextButton(
                                          lable: 'confirm',
                                          ontap: () async {
                                            setState(() {
                                              showdilog();
                                            });
                                            try {
                                              var res = await FirebaseFirestore
                                                  .instance
                                                  .collection('booking')
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({"approve": 1});

                                              setState(() {
                                                Get.back();
                                                showbar(
                                                    'updated booking',
                                                    'subtitle',
                                                    'updated booking',
                                                    true);
                                              });
                                            } catch (e) {
                                              setState(() {
                                                Get.back();
                                                showbar(
                                                    'updated booking',
                                                    'subtitle',
                                                    e.toString(),
                                                    false);
                                              });
                                            }
                                          },
                                          color: Colors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                          // );
                        });
                  }
                }
              })),
    );
  }

  void change(String id, String field) async {
    TextEditingController change = TextEditingController();
    Get.defaultDialog(
        title: 'Edit',
        content: SingleChildScrollView(
          child: TextFormField(
            // keyboardType: TextInputType.number,
            controller: change,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              // labelText: 'Username',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field can be empty";
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              showdilog();
              try {
                var fielde = field == 'No' ? int.tryParse(field) : field;
                await FirebaseFirestore.instance
                    .collection('center')
                    .doc(id)
                    .update({fielde.toString(): change.text});

                change.clear();
                Get.back();
                Get.back();
                Get.snackbar('done', 'done',
                    backgroundColor: Colors.greenAccent);
              } catch (e) {
                Get.back();
                Get.back();
                Get.snackbar('Done', e.toString(), backgroundColor: Colors.red);
              }
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
                change.clear();
              },
              child: const Text(
                "Exit",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ]);
    // var res = await collectionReference.doc(id).update(attribute);
  }
}
