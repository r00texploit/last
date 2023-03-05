import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/details/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:details/screens/admin/widgets/custom_button.dart';
import 'package:details/screens/admin/widgets/loading.dart';
import 'package:details/screens/admin/widgets/snackbar.dart';

class Showcenter extends StatefulWidget {
  const Showcenter({Key? key}) : super(key: key);

  @override
  State<Showcenter> createState() => _ShowcenterState();
}

class _ShowcenterState extends State<Showcenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All center'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('center').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No Available requset',
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
                                        "center email:  ${snapshot.data!.docs[index]['email']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'email');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'center password: ${snapshot.data!.docs[index]['password']}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          change(snapshot.data!.docs[index].id,
                                              'password');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Center(
                                  child: CustomTextButton(
                                      lable: 'Delete',
                                      ontap: () async {
                                        setState(() {
                                          showdilog();
                                        });
                                        try {
                                          var res = await FirebaseFirestore
                                              .instance
                                              .collection('center')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          setState(() {
                                            Get.back();
                                            showbar('delete center', 'subtitle',
                                                'center deleted', true);
                                          });
                                        } catch (e) {
                                          setState(() {
                                            Get.back();
                                            showbar('delete center', 'subtitle',
                                                e.toString(), false);
                                          });
                                        }
                                      },
                                      color: Colors.red),
                                )
                              ],
                            ),
                          );
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
