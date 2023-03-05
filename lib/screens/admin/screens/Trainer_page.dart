import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/screens/admin/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:details/screens/admin/widgets/custom_button.dart';
import 'package:details/screens/admin/widgets/loading.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 72, 77),
        title: const Text('Trainer Page'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('training').snapshots(),
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
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Trainer name: ${snapshot.data!.docs[index]['name']}',
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
                                              'name');
                                        },
                                        icon: Icon(Icons.edit))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Trainer email: ${snapshot.data!.docs[index]['email']}',
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
                                        'Trainer number: ${snapshot.data!.docs[index]['number']}',
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
                                              'number');
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
                                              .collection('training')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          setState(() {
                                            Get.back();
                                            showbar(
                                                'delete training',
                                                'subtitle',
                                                'training deleted',
                                                true);
                                          });
                                        } catch (e) {
                                          setState(() {
                                            Get.back();
                                            showbar(
                                                'delete training',
                                                'subtitle',
                                                e.toString(),
                                                false);
                                          });
                                        }
                                      },
                                      color: Colors.red),
                                )
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     ': ${snapshot.data!.docs[index]['']}',
                                //     style: const TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // Center(
                                //   child: CustomTextButton(
                                //       lable: 'add registration fees',
                                //       ontap: () async {
                                //         change(snapshot.data!.docs[index].id);
                                //       },
                                //       color: Colors.blueAccent),
                                // )
                              ],
                            ),
                          );
                        });
                  }
                }
              })),
    );
  }

  // void change(String id) async {
  //   TextEditingController change = TextEditingController();
  //   Get.defaultDialog(
  //       title: 'add fees',
  //       content: SingleChildScrollView(
  //         child: TextFormField(
  //           // keyboardType: TextInputType.number,
  //           controller: change,
  //           decoration: const InputDecoration(
  //             icon: Icon(Icons.account_circle),
  //             labelText: 'price',
  //           ),
  //           validator: (value) {
  //             if (value!.isEmpty) {
  //               return "This field can be empty";
  //             }
  //             return null;
  //           },
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () async {
  //             showdilog();
  //             try {
  //               await FirebaseFirestore.instance
  //                   .collection('users')
  //                   .doc(id)
  //                   .update({"fees": change.text});

  //               change.clear();
  //               Get.back();
  //               Get.back();
  //               Get.snackbar('done', 'done',
  //                   backgroundColor: Colors.greenAccent);
  //             } catch (e) {
  //               Get.back();
  //               Get.back();
  //               Get.snackbar('Done', e.toString(), backgroundColor: Colors.red);
  //             }
  //           },
  //           child: const Text(
  //             "save",
  //             style: TextStyle(color: Colors.black, fontSize: 20),
  //           ),
  //         ),
  //         TextButton(
  //             onPressed: () {
  //               Get.back();
  //               change.clear();
  //             },
  //             child: const Text(
  //               "exit",
  //               style: TextStyle(color: Colors.black, fontSize: 20),
  //             )),
  //       ]);
  //   // var res = await collectionReference.doc(id).update(attribute);
  // }
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
                    .collection('training')
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
