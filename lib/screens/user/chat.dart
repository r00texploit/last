import 'dart:developer';
import 'dart:math';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/AdminHome.dart';
import 'package:details/model/chatmodel/apiHelper.dart';
import 'package:details/model/chatmodel/messageModel.dart';
import 'package:details/screens/Chat/chat_screen.dart';
import 'package:details/screens/Chat/image_view_screen.dart';
import 'package:details/screens/Chat/size_config.dart';
import 'package:details/widget/toastfile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import 'package:details/screens/Chat/chat_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:details/model/chatmodel/global.dart' as global;
import "package:collection/collection.dart";

// void main() {
//   runApp(MyApp());
// }

// class Chat extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Chat UI',
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 72, 77),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _top(),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chat with \nyour Trainer',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: CustomScrollView(shrinkWrap: true, slivers: [
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('training')
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
                          return
                              // Expanded(
                              //   child:
                              Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45),
                                  topRight: Radius.circular(45)),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                                // scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.only(top: 35),
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  print(snapshot.data!.docs[index]['uid']);
                                  return _itemChats(
                                    avatar: snapshot.data!.docs[index]['img'],
                                    name: snapshot.data!.docs[index]['name'],
                                    userid: snapshot.data!.docs[index]['uid'],
                                    tel: snapshot.data!.docs[index]['number'],
                                  );
                                }),
                          );
                        }
                      }
                    }))
          ],
        ))
      ]),
    );
  }

  Widget _itemChats({
    String? avatar,
    name,
    tel,
    userid,
  }) {
    return GestureDetector(
        onTap: () {
          Get.to(
              () => ChatScreen1(name: name, tel: tel, img: avatar, uid: userid));
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         ChatScreen1(name: name, tel: tel, img: avatar, uid: uid),
          //   ),
          // );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
          child: Row(children: [
            // Avater(
            //   margin: const EdgeInsets.only(right: 20),
            //   size: 60,
            //   Image: Image.network(avatar!,height: 80,width: 80,scale: 1),
            // ),
            Image.asset("assets/image/private_trainer.jpg", height: 80, width: 80, scale: 1),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$name',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]))
          ]),
        ));
  }
}

class ChatPage extends StatefulWidget {
  String? name;
  String? tel;
  String? img;
  ChatPage({this.name, super.key, this.tel, this.img});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 72, 77),
      body: Flex(direction: Axis.vertical, children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                topChat(),
                // bodyChat(),
                // _formchat()
              ],
            ),
            ChatScreen(),
            _formchat(),
          ]),
        ),
      ]),
    );
  }

  Widget topChat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.img!,
                  scale: 1,
                  // fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                widget.name!,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.black12,
                ),
                child: IconButton(
                  // Icons.call,
                  // size: 25,
                  color: Colors.white,
                  onPressed: () {
                    var teluri = Uri.parse(widget.tel.toString());
                    launchUrlString("tel:$teluri");
                  },
                  icon: const Icon(Icons.call, size: 25),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );
  var apiHelper = APIHelper();
  List<MessagesModel>? messages = [];
  bool isDone = false;
  Widget bodyChat() {
    return
        // LayoutBuilder(
        //   builder: (context, constraints) =>
        SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          // Expanded(
          //   child:
          StreamBuilder<List<MessagesModel>>(
              stream: apiHelper.getChatMessages(
                global.uid.toString(),
                global.TID,
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  default:
                    if (snapshot.hasError) {
                      return buildText('something went wrong');
                    } else {
                      messages = snapshot.data;
                      if (messages == null) {
                        messages = [];
                      }

                      return messages!.isEmpty
                          ? buildText('say HI')
                          : Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * 12),
                              child: ListView.builder(
                                reverse: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: messages!.length,
                                itemBuilder: (context, index) {
                                  var groupDate = groupBy(
                                      messages!,
                                      (dynamic a) => a.createdAt
                                          .toString()
                                          .substring(0, 10));
                                  groupDate.forEach((key, value) {
                                    MessagesModel m = value.lastWhere((e) =>
                                        e.createdAt
                                            .toString()
                                            .substring(0, 10) ==
                                        key.toString());
                                    messages![messages!.indexOf(m)].isShowDate =
                                        true;
                                    isDone = true;
                                  });
                                  final message = messages![index];
                                  return _buildMessage(
                                    message,
                                    message.userId1 == global.uid.toString(),
                                  );
                                },
                              ),
                            );
                    }
                }
              }),
          // )
        ],
        // ),
      ),
    );
  }

  DateTime _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  _buildMessage(MessagesModel message, bool isMe) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle timeStampStyle =
        textTheme.caption!.copyWith(color: Colors.grey[400], fontSize: 12);
    DateTime _indexTime = DateTime(message.createdAt!.year,
        message.createdAt!.month, message.createdAt!.day);
    return Column(
      children: [
        message.isShowDate
            ? Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        _today.difference(_indexTime).inDays == 0
                            ? 'today'
                            : _today.difference(_indexTime).inDays == 1
                                ? 'yesterday'
                                : DateFormat('MMM dd, yyyy')
                                    .format(message.createdAt!),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 0.6,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        isMe
            ? Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        if (message.url != '') {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, animation1, animation2) =>
                                  ImageViewScreen()));
                        }
                      },
                      child: Container(
                        height: message.message == global.imageUploadMessageKey
                            ? 200
                            : null,
                        width: message.message == global.imageUploadMessageKey
                            ? 200
                            : null,
                        margin: isMe
                            ? const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 50.0)
                            : const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 80.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: message.url != ""
                                ? DecorationImage(
                                    image: NetworkImage(message.url!),
                                    fit: BoxFit.cover)
                                : null,
                            border:
                                message.message == global.imageUploadMessageKey
                                    ? Border.all(color: Colors.white, width: 2)
                                    : null,
                            borderRadius: isMe
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(15.0))
                                : const BorderRadius.only(
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0))),
                        child: message.message ==
                                    global.imageUploadMessageKey &&
                                message.url == ""
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : (message.message != "" &&
                                    message.message !=
                                        global.imageUploadMessageKey)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(3),
                                        constraints: const BoxConstraints(
                                          maxWidth: 60,
                                          //  MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     .6
                                        ),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF4F4F4),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: Text(
                                          message.message!,
                                          style: textTheme.bodyText1,
                                        ),
                                      ),
                                      Text(
                                        '${DateFormat().add_jm().format(message.createdAt!)}',
                                        style: timeStampStyle,
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                      ),
                    )),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.person),
                    Flexible(
                        child: Container(
                      height: message.message == global.imageUploadMessageKey
                          ? 200
                          : null,
                      width: message.message == global.imageUploadMessageKey
                          ? 200
                          : null,
                      margin: isMe
                          ? const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 50.0)
                          : const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 80.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: message.url != ""
                              ? DecorationImage(
                                  image: NetworkImage(message.url!),
                                  fit: BoxFit.cover)
                              : null,
                          border:
                              message.message == global.imageUploadMessageKey
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                          borderRadius: isMe
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  bottomLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(15.0))
                              : const BorderRadius.only(
                                  bottomRight: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0))),
                      child: message.message == global.imageUploadMessageKey &&
                              message.url == ""
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : (message.message != "" &&
                                  message.message !=
                                      global.imageUploadMessageKey)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(3),
                                      constraints: BoxConstraints(
                                        maxWidth: 60,
                                        //  MediaQuery.of(context)
                                        //         .size
                                        //         .width *
                                        //     .6
                                      ),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF4F4F4),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Text(
                                        message.message!,
                                        style: textTheme.bodyText1,
                                      ),
                                    ),
                                    Text(
                                      '${DateFormat().add_jm().format(message.createdAt!)}',
                                      style: timeStampStyle,
                                    )
                                  ],
                                )
                              : const SizedBox(),
                    )),
                  ],
                ),
              )
      ],
    );
  }

  Widget _itemChat({chat, avatar, message, time}) {
    return Row(
      mainAxisAlignment:
          chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        avatar != null
            ? Avater(
                Image: avatar,
                size: 50,
              )
            : Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: chat == 0
                        ? Colors.indigo.shade100
                        : Colors.indigo.shade50,
                    borderRadius: chat == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                  ),
                  child: Text('$message'),
                ),
              ),
        chat == 1
            ? Text(
                '$time',
                style: TextStyle(color: Colors.grey.shade400),
              )
            : const SizedBox(),
      ],
    );
  }

  TextEditingController _message = TextEditingController();
  Widget _formchat() {
    return Positioned(
        child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: TextField(
          controller: _message,
          decoration: InputDecoration(
            hintText: 'Type your message...',
            filled: true,
            fillColor: const Color.fromARGB(255, 4, 72, 77),
            floatingLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            contentPadding: const EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade100)),
            suffix: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 4, 72, 77)),
                child: IconButton(
                  onPressed: () async {
                    await sendMessage();
                  },
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                )),
          ),
        ),
      ),
    ));
  }

  bool isAlreadyChat = false;
  MessagesModel messageModel = new MessagesModel();
  Future<void> sendMessage() async {
    try {
      int? id = Random().nextInt(9999) * 10;
      if (global.uid != null) {
        isDone = false;
        debugPrint("id: ${id}");
        if (_message.text.trim() != '') {
          messageModel.message = _message.text;
          messageModel.id = id;
          messageModel.isActive = true;
          messageModel.isDelete = false;
          messageModel.createdAt = DateTime.now();
          messageModel.updatedAt = DateTime.now();
          messageModel.isRead = true;
          messageModel.userId1 = global.uid.toString();
          messageModel.userId2 = global.TID;
          messageModel.url = "";
          _message.clear();
          await apiHelper.uploadMessage(
              global.uid, global.TID, messageModel, isAlreadyChat, '');

          setState(() {
            isAlreadyChat = true;
          });
        }
      } else {
        showSnackBar(
            key: _scaffoldKey, snackBarMessage: 'something went wrong');
      }
    } catch (e) {
      debugPrint("Exception - ChatScreen.dart - sendMessage():" + e.toString());
      print("Exception - ChatScreen.dart - sendMessage():" + e.toString());
    }
  }

  void showSnackBar(
      {required String snackBarMessage, GlobalKey<ScaffoldState>? key}) {
    showResultSnackBar(snackBarMessage);
  }

  GlobalKey<ScaffoldState>? _scaffoldKey;
}

class Avater extends StatelessWidget {
  final double size;
  final Image;
  final EdgeInsets margin;
  Avater({this.Image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  Widget build(BuildContext context) {
    return Padding(
        padding: margin,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(Image),
              )),
        ));
  }
}
