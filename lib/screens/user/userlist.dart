// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:details/screens/login_screen.dart';
// import 'package:details/training_list_chat.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// CollectionReference chatRef = FirebaseFirestore.instance.collection("chats");

// class ChatsUser extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // UserViewModel viewModel =
//     //     Provider.of<UserViewModel>(context, listen: false);
//     // viewModel.setUser();
//     return Scaffold(
//         appBar: AppBar(
//           leading: GestureDetector(
//             onTap: () {
//               Get.to(() => LoginScreen());
//             },
//             child: Icon(Icons.keyboard_backspace),
//           ),
//           title: Text("Chats"),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//             stream: userChatsStream(FirebaseAuth.instance.currentUser!.uid),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List chatList = snapshot.data!.docs;
//                 if (chatList.isNotEmpty) {
//                   return ListView.separated(
//                     itemCount: chatList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       DocumentSnapshot chatListSnapshot = chatList[index];
//                       return StreamBuilder<QuerySnapshot>(
//                           stream: messageListStream(chatListSnapshot.id),
//                           builder:
//                               (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                             if (!snapshot.hasData) {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             } else {
//                               if (snapshot.data!.docs.isEmpty) {
//                                 return const Center(
//                                   child: Text('No A vailable requset',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white)),
//                                 );
//                               } else {
//                                 return
//                                     //  Expanded(
//                                     //     child:
//                                     Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30),
//                                   width: double.infinity,
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(45),
//                                         topRight: Radius.circular(45)),
//                                     color: Colors.white,
//                                   ),
//                                   child: ListView.builder(
//                                       // scrollDirection: Axis.vertical,
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.vertical,
//                                       padding: const EdgeInsets.only(top: 35),
//                                       physics: const BouncingScrollPhysics(),
//                                       itemCount: snapshot.data!.docs.length,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         // print(snapshot.data!.docs[index]['uid']);
//                                         // var chats = FirebaseFirestore.instance
//                                         //     .collection('messages')
//                                         //     .where("uid",
//                                         //         isEqualTo: snapshot.data!.docs[index]
//                                         //             .get("uid"));
//                                         // queryValues(snapshot.data!.docs[index]
//                                         // ['email']);
//                                         return _itemChats(
//                                           // avatar: snapshot.data!.docs[index]['img'],
//                                           name: snapshot.data!.docs[index]
//                                               ['name'],
//                                           userid: snapshot.data!.docs[index]
//                                               ['uid'],
//                                           tel: snapshot.data!.docs[index]
//                                               ['number'],
//                                         );
//                                         // }
//                                       }),
//                                   // )
//                                 );
//                               }
//                             }
//                           });
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return Align(
//                         alignment: Alignment.centerRight,
//                         child: Container(
//                           height: 0.5,
//                           width: MediaQuery.of(context).size.width / 1.3,
//                           child: Divider(),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(child: Text('No Chats'));
//                 }
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//             }));
//   }
// }
// // }));
// // }

// Stream<QuerySnapshot> userChatsStream(String uid) {
//   return chatRef
//       .where('users', arrayContains: uid)
//       .orderBy('lastTextTime', descending: true)
//       .snapshots();
// }

// Stream<QuerySnapshot> messageListStream(String documentId) {
//   return chatRef
//       .doc(documentId)
//       .collection('messages')
//       .orderBy('time', descending: true)
//       .snapshots();
// }

// Widget _itemChats({
//   String?
//       // avatar,
//       name,
//   tel,
//   userid,
// }) {
//   return GestureDetector(
//       onTap: () {
//         Get.to(() =>
//             ChatScreen2(name: name, tel: tel, /*img: avatar*/ uid: userid));
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (context) =>
//         //         ChatScreen1(name: name, tel: tel, img: avatar, uid: uid),
//         //   ),
//         // );
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 20),
//         elevation: 0,
//         child: Row(children: [
//           // Avater(
//           //   margin: const EdgeInsets.only(right: 20),
//           //   size: 60,
//           //   Image: Image.network(avatar!,height: 80,width: 80,scale: 1),
//           // ),
//           // Image.network(avatar!, height: 80, width: 80, scale: 1),
//           Expanded(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '$name',
//                       style: const TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ]))
//         ]),
//       ));
// }
// // }
