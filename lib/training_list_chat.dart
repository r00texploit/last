import 'dart:developer';

import 'package:details/controller/auth_controller.dart';
import 'package:details/model/chatmodel/global.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
// import 'package:login/Account/Center_page/screens/details/componants/center.dart';

final _firestore = FirebaseFirestore.instance;

final _auth = FirebaseAuth.instance;
late User signedInUser;
String? messageText;

class ChatScreen2 extends StatefulWidget {
  static const String screenRoute = 'chat_screen';
  String? img, name, tel, uid, email;
  ChatScreen2(
      {Key? key,
      img,
      required this.name,
      required this.tel,
      required this.uid,
      required this.email})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen2> {
  TextEditingController messageController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  //void getMessages() async {
  //  final messages = await _firestore.collection('messages').get();
  //  for (var message in messages.docs) {
  //  print(message.data());
  //}
  //}
  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print((message.data()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.tel = null;
    widget.img = null;
    widget.name = null;
    widget.uid = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          //750
          children: [
            // Image.asset('images/logo.png', height: 25),
            SizedBox(width: 10),
            Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              var ctrl = Get.put(AuthController());
              // messagesStreams();
              ctrl.signOut();
              // Navigator.pop(context);
              // Get.back();
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chats')
                    .doc(_auth.currentUser!.uid)
                    .collection("messages")
                    .doc(widget.uid)
                    .collection("users")
                    // .where("receiver", isEqualTo: widget.uid)
                    // .where("sender", isEqualTo: signedInUser.email)
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<MessageLine> messageWidgets = [];
                  if (snapshot.hasData) {}
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs;
                  for (var message in messages) {
                    final messageSender = message.get('sender');
                    final messageText = message.get('text');
                    final currentUser = signedInUser.email;
                    final receiver = message.get("receiver");

                    final messageWidget = MessageLine(
                      sender: messageSender,
                      text: messageText,
                      isMe: currentUser == messageSender,
                      receiver: receiver,
                    );
                    // if(currentUser==_auth.currentUser!.email || receiver == _auth.currentUser!.uid)
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      children: messageWidgets,
                    ),
                  );
                }),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      log("message:$uid");
                      _firestore
                          .collection('chats')
                          .doc(_auth.currentUser!.uid)
                          .collection("messages")
                          .doc(widget.uid)
                          .collection("users")
                          .add({
                        'sender': signedInUser.email,
                        'receiver': widget.uid,
                        'text': messageController.text.trim(),
                        'time': FieldValue.serverTimestamp(),
                        //'isTrainer': true,
                      });
                      messageController.clear();
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  MessageLine(
      {this.sender,
      this.text,
      Key? key,
      required this.isMe,
      required this.receiver})
      : super(key: key);
  final String? sender;
  final String? text;
  final String? receiver;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
              elevation: 5,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              color: isMe ? Colors.blue : Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$text',
                  style: TextStyle(
                      fontSize: 15, color: isMe ? Colors.white : Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
