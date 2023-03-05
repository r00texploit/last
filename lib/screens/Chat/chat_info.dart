import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:details/model/chatmodel/chatmodel.dart';
import 'package:details/model/chatmodel/messageModel.dart';
import 'package:details/screens/Chat/chat_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:details/model/chatmodel/global.dart' as global;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'image_detail.dart';

class EmailExist {
  String? id;
  bool? isEMailExist;
  EmailExist({this.id, this.isEMailExist});
}

class MessageField {
  static final String createdAt = 'createdAt';
  static final bool isRead = true;
}

class Utils {
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) {
    return StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
        List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final users = snaps
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();

        sink.add(users);
      },
    );
  }

  static DateTime? toDateTime(Timestamp? value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }
}

class ChatInfo extends StatefulWidget {
  final String? chatId;
  final int? storeId;
  final int? userId;
  final String? name;
  final String? userFcmToken;

  ChatInfo(
      {this.name, this.storeId, this.chatId, this.userId, this.userFcmToken});

  @override
  _ChatInfoState createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  DateTime _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var http = Client();
  File? _tImage;
  bool isLoading = true;
  dynamic apCurrency;
  List<MessagesModel>? messages = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isShowSticker = false;
  TextEditingController _message = new TextEditingController();
  ChatModel chatModel = ChatModel();
  MessagesModel messagesModel = new MessagesModel();
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference chatsCollectionRef =
      FirebaseFirestore.instance.collection("chats");
  CollectionReference userChatCollectionRef =
      FirebaseFirestore.instance.collection("userchat");
  int? storeId;
  bool isAlreadyChat = false;
  bool isDone = false;
  @override
  void initState() {
    super.initState();
    print(widget.storeId);
    _init();
  }

  Future _init() async {
    try {
      int daydiff = (_today.difference(DateTime.now()).inHours / 24).round();
      print('$daydiff');
      int date = daysBetween(_today, DateTime.now());
      print(date);
    } catch (e) {
      print('Exception - chat_info.dart - _init():' + e.toString());
    }
  }

  @override
  void dispose() {
    try {
      http.close();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 12).round();
  }

  @override
  Widget build(BuildContext context) {
    var groupDate = groupBy(messages!, (dynamic a) => a.createdAt);
    groupDate.forEach((key, value) {
      MessagesModel m =
          value.lastWhere((e) => e.createdAt.toString() == key.toString());
      print('Getting element m' + m.message!);
    });

    _buildMessage(MessagesModel message, bool isMe) {
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
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          // color: Colors.white30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          '${_today.difference(_indexTime).inDays == 0 ? 'Today' : _today.difference(_indexTime).inDays == 1 ? 'Yesterday' : DateFormat('MMM dd, yyyy').format(message.createdAt!)}',
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          // color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
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
                                    ImageDetail(
                                      message.url,
                                    )));
                          }
                        },
                        child: Container(
                          height:
                              message.message == global.imageUploadMessageKey
                                  ? 200
                                  : null,
                          width: message.message == global.imageUploadMessageKey
                              ? 200
                              : null,
                          margin: isMe
                              ? EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 50.0)
                              : EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, right: 80.0),
                          // padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: message.url != ""
                                  ? DecorationImage(
                                      image: NetworkImage(message.url!),
                                      fit: BoxFit.cover)
                                  : null,
                              border: message.message ==
                                      global.imageUploadMessageKey
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                              borderRadius: isMe
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0))
                                  : BorderRadius.only(
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0))),
                          child: message.message ==
                                      global.imageUploadMessageKey &&
                                  message.url == ""
                              ? Center(
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
                                            margin: EdgeInsets.all(3),
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6),
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25),
                                              ),
                                            ),
                                            child: Text(
                                              '${message.message}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              '${DateFormat().add_jm().format(message.createdAt!)}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .color,
                                                  fontSize: 12)),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
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
                      Flexible(
                          child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (_, animation1, animation2) =>
                                  ImageDetail(
                                    message.url,
                                  )));
                        },
                        child: Container(
                          height:
                              message.message == global.imageUploadMessageKey
                                  ? 200
                                  : null,
                          width: message.message == global.imageUploadMessageKey
                              ? 200
                              : null,
                          margin: isMe
                              ? EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 50.0)
                              : EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, right: 80.0),
                          // padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: message.url != ""
                                  ? DecorationImage(
                                      image: NetworkImage(message.url!),
                                      fit: BoxFit.cover)
                                  : null,
                              border: message.message ==
                                      global.imageUploadMessageKey
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                              borderRadius: isMe
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      bottomLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(15.0))
                                  : BorderRadius.only(
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      bottomLeft: Radius.circular(15.0))),
                          child: message.message ==
                                      global.imageUploadMessageKey &&
                                  message.url == ""
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (message.message != "" &&
                                      message.message !=
                                          global.imageUploadMessageKey)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6),
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFDDDFF5),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(25),
                                              ),
                                            ),
                                            child: Text(
                                              '${message.message}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                              '${DateFormat().add_jm().format(message.createdAt!)}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .color,
                                                  fontSize: 12)),
                                        )
                                      ],
                                    )
                                  : SizedBox(),
                        ),
                      )),
                    ],
                  ),
                ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        onBackPress();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              onBackPress();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF34385A),
            ),
          ),
          title: Text(
            widget.name!,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: (isLoading)
            ? WillPopScope(
                onWillPop: () async {
                  onBackPress();
                  return false;
                },
                child: Scrollbar(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      isLoading
                          ? Expanded(
                              flex: 2,
                              child: StreamBuilder<List<MessagesModel>>(
                                  stream: getChatMessages(
                                      widget.chatId, widget.storeId.toString()),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      default:
                                        if (snapshot.hasError) {
                                          print(snapshot.error);
                                          return buildText(
                                              //AppLocalizations.of(context).txt_something_went_wrong_try_later,
                                              'Something Went Wrong Try later');
                                        } else {
                                          messages = snapshot.data;
                                          if (messages == null) {
                                            messages = [];
                                          }

                                          return messages!.isEmpty
                                              ? buildText(
                                                  //AppLocalizations.of(context).txt_say_hi,
                                                  'say hi')
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: isShowSticker
                                                          ? 330
                                                          : 90),
                                                  child: ListView.builder(
                                                    reverse: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: messages!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      //   if (!isDone) {
                                                      var groupDate = groupBy(
                                                          messages!,
                                                          (dynamic a) => a
                                                              .createdAt
                                                              .toString()
                                                              .substring(
                                                                  0, 10));
                                                      groupDate.forEach(
                                                          (key, value) {
                                                        print("key  " +
                                                            key.toString());
                                                        MessagesModel m = value
                                                            .lastWhere((e) =>
                                                                e.createdAt
                                                                    .toString()
                                                                    .substring(
                                                                        0,
                                                                        10) ==
                                                                key.toString());
                                                        // _messageList[_messageList.indexOf(m)].isShowTime = true;
                                                        messages![messages!
                                                                .indexOf(m)]
                                                            .isShowDate = true;
                                                        isDone = true;
                                                        print('  ${key.toString()}  +  ' +
                                                            m.createdAt
                                                                .toString()
                                                                .substring(
                                                                    0, 10) +
                                                            '${m.createdAt.toString().substring(0, 10) == key.toString()}');
                                                      });
                                                      //  }
                                                      final message =
                                                          messages![index];
                                                      // var groupDate = groupBy(event1, (a) => a.createdAt.substring(0, 10));
                                                      // groupDate.forEach((key, value) {
                                                      //   MessagesModel mmodel = value.lastWhere((e) => e.createdAt.toString().substring(0, 10) == key.toString());
                                                      //   print("grouptt   ${mmodel.createdAt}  ");
                                                      // });
                                                      // print('real list lenght' + messages.length.toString());
                                                      return _buildMessage(
                                                        message,
                                                        message.userId1 ==
                                                            widget.storeId
                                                                .toString(),
                                                      );
                                                    },
                                                  ),
                                                );
                                        }
                                    }
                                  }),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
        bottomSheet: Container(
          margin: EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    _showCupertinoModalSheet();
                  },
                  icon: Icon(Icons.camera)),
              Expanded(
                child: TextFormField(
                  controller: _message,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText:
                        //AppLocalizations.of(context).hnt_type_your_message,
                        ' Type your Message',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        size: 25,
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    contentPadding: EdgeInsets.only(top: 5, left: 5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('Actions'),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                'Take Picture',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
                MessagesModel messageModel = new MessagesModel();
                // showOnlyLoaderDialog();
                _tImage = await openCamera();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = widget.storeId.toString();
                  messageModel.userId2 = widget.userId.toString();
                  messageModel.url = "";
                  await uploadImageToStorage(_tImage!, widget.chatId!,
                      widget.userId.toString(), messageModel);

                  setState(() {});
                }
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Choose from gallery',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
                MessagesModel messageModel = new MessagesModel();
                // showOnlyLoaderDialog();
                _tImage = await selectImageFromGallery();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = widget.storeId.toString();
                  messageModel.userId2 = widget.userId.toString();
                  messageModel.url = "";
                  await uploadImageToStorage(_tImage!, widget.chatId!,
                      widget.userId.toString(), messageModel);

                  setState(() {});
                }
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - SignUpScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }

  Future<String?> uploadImageToStorage(
      File image, String chatId, String userid, MessagesModel anonymous) async {
    try {
      var messageR = await uploadMessage(chatId, userid, anonymous);
      print("Chat Id" + chatId);
      var fileName = DateTime.now().microsecondsSinceEpoch.toString();
      //var StorageUploadTask = FirebaseStorage.instance;
      var refImg = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = refImg.putFile(image);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      await updateImageMesageURL(
          chatId, widget.storeId.toString(), messageR['user1'], imageUrl);
      await updateImageMesageURL(chatId, userid, messageR['user2'], imageUrl);
      print('imageUrl $imageUrl');

      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? url;

  Future updateImageMesageURL(
      String chatId, String userId, String? messageId, String url) async {
    try {
      var _myDoc = FirebaseFirestore.instance
          // .collection('chats/$chatId/messages')
          .collection('chats')
          .doc(chatId)
          .collection('userschat')
          .doc(userId)
          .collection('messages')
          .doc(messageId);

      //  FirebaseFirestore.instance.collection('chats/$chatId/messages');
      _myDoc.update({'url': url});
    } catch (err) {
      print('Exception: updateImageMesageURL(): ${err.toString()}');
    }
  }

  // Future<File?> openCamera() async {
  //   try {
  //     PermissionStatus permissionStatus = await Permission.camera.status;
  //     if (permissionStatus.isLimited || permissionStatus.isDenied) {
  //       permissionStatus = await Permission.camera.request();
  //     }
  //     //File imageFile;
  //     XFile _selectedImage = await (ImagePicker().pickImage(
  //         source: ImageSource.camera,
  //         maxHeight: 1200,
  //         maxWidth: 1200) as FutureOr<XFile>);
  //     File imageFile = File(_selectedImage.path);
  //     File _finalImage = await (_cropImage(imageFile.path) as FutureOr<File>);

  //     _finalImage =
  //         await (_imageCompress(_finalImage, imageFile.path) as FutureOr<File>);

  //     print("_byteData path ${_finalImage.path}");
  //     return _finalImage;
  //   } catch (e) {
  //     print("Exception - businessRule.dart - openCamera():" + e.toString());
  //   }
  //   return null;
  // }

  // Future<File?> selectImageFromGallery() async {
  //   try {
  //     PermissionStatus permissionStatus = await Permission.photos.status;
  //     if (permissionStatus.isLimited || permissionStatus.isDenied) {
  //       permissionStatus = await Permission.photos.request();
  //     }
  //     File imageFile;
  //     XFile? _selectedImage = await (ImagePicker()
  //         .pickImage(source: ImageSource.gallery)); // as FutureOr<XFile?>
  //     log("image: ${_selectedImage!.path}");
  //     imageFile = File(_selectedImage.path);
  //     File? _byteData = await (_cropImage(imageFile.path) as FutureOr<File?>);
  //     _byteData =
  //         await (_imageCompress(_byteData!, imageFile.path) as FutureOr<File?>);
  //     return _byteData;
  //   } catch (e) {
  //     print("Exception - businessRule.dart - selectImageFromGallery()" +
  //         e.toString());
  //   }
  //   return null;
  // }

  // Future<File?> _cropImage(String sourcePath) async {
  //   try {
  //     File? _croppedFile = (await ImageCropper().cropImage(
  //       sourcePath: sourcePath,
  //       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
  //       uiSettings: [
  //         AndroidUiSettings(
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           backgroundColor: Colors.white,
  //           toolbarColor: Colors.black,
  //           dimmedLayerColor: Colors.white,
  //           toolbarWidgetColor: Colors.white,
  //           cropGridColor: Colors.white,
  //           activeControlsWidgetColor: Color(0xFF46A9FC),
  //           cropFrameColor: Color(0xFF46A9FC),
  //           lockAspectRatio: true,
  //         ),
  //       ],
  //     )) as File?;
  //     if (_croppedFile != null) {
  //       return _croppedFile;
  //     }
  //   } catch (e) {
  //     print("Exception - businessRule.dart - _cropImage():" + e.toString());
  //   }
  //   return null;
  // }

  // Future<File?> _imageCompress(File file, String targetPath) async {
  //   try {
  //     var result = await (FlutterImageCompress.compressAndGetFile(
  //       file.path,
  //       targetPath,
  //       minHeight: 1200,
  //       minWidth: 1200,
  //       quality: 50,
  //     ) as FutureOr<File>);
  //     print('file ${file.lengthSync()}');
  //     print(result.lengthSync());

  //     return result;
  //   } catch (e) {
  //     print("Exception - businessRule.dart - _cropImage():" + e.toString());
  //     return null;
  //   }
  // }

  Future<File?> openCamera() async {
    try {
      PermissionStatus permissionStatus = await Permission.camera.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.camera.request();
      }
      XFile? _selectedImage =
          await (ImagePicker().pickImage(source: ImageSource.camera));
      File imageFile = File(_selectedImage!.path);

      File? _finalImage = await (_cropImage(imageFile.path));

      _finalImage = await (_imageCompress(_finalImage!, imageFile.path));

      return _finalImage;
    } catch (e) {
      print("Exception - profile_picture.dart - openCamera():" + e.toString());
    }
    return null;
  }

  Future<File?> selectImageFromGallery() async {
    try {
      PermissionStatus permissionStatus = await Permission.photos.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.photos.request();
      }
      File imageFile;

      XFile? _selectedImage =
          await (ImagePicker().pickImage(source: ImageSource.gallery));

      imageFile = File(_selectedImage!.path);

      File? _byteData = await (_cropImage(imageFile.path));
      log('NO EXCEPTION 1');
      log((_byteData == null).toString());
      _byteData = await (_imageCompress(_byteData!, imageFile.path));
      log('NO EXCEPTION 2');
      log(_byteData!.path.toString());
      return _byteData;
    } catch (e) {
      log("HERE IS EXCEPATION" + e.toString());
      print("Exception - profile_picture.dart - selectImageFromGallery()" +
          e.toString());
    }
    return null;
  }

  Future<File?> _cropImage(String sourcePath) async {
    try {
      var croppedImage = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            backgroundColor: Colors.white,
            toolbarColor: Colors.black,
            dimmedLayerColor: Colors.white,
            toolbarWidgetColor: Colors.white,
            cropGridColor: Colors.white,
            activeControlsWidgetColor: Color(0xFF46A9FC),
            cropFrameColor: Color(0xFF46A9FC),
            lockAspectRatio: true,
          ),
        ],
      );

      File? _croppedFile = File(croppedImage!.path);

      log(_croppedFile.toString());
      return _croppedFile;
    } catch (e) {
      log(e.toString());
      print("Exception - profile_picture.dart - _cropImage():" + e.toString());
    }
    return null;
    // return null;
  }

  Future<File?> _imageCompress(File file, String targetPath) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minHeight: 500,
        minWidth: 500,
        quality: 60,
      );

      return result;
    } catch (e) {
      print("Exception - profile_picture.dart - _cropImage():" + e.toString());
      return null;
    }
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );

  Future<bool> onBackPress() async {
    await updateLastMessage(
        widget.storeId, widget.userId, messages!.first.message);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatListPage()));

    return Future.value(false);
  }

  Future updateLastMessage(
      int? storeId, int? userId, String? lastMessage) async {
    List<QueryDocumentSnapshot> storeData = (await FirebaseFirestore.instance
            .collectionGroup("store")
            .where('storeId', isEqualTo: storeId)
            .where('userId', isEqualTo: userId)
            .get())
        .docs
        .toList();
    //  await FirebaseFirestore.instance.collection('store').doc('57bo3HAIqqxeqFFMvmH1').update({'lastMessage':'Hey'});
    if (storeData.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("store")
          .doc(storeData[0].id)
          .update({
        "lastMessage": lastMessage,
        "lastMessageTime": DateTime.now().toUtc(),
        "updatedAt": DateTime.now().toUtc()
      });
    }
    print('hello ');
  }

  Future<void> sendMessage() async {
    if (widget.chatId != null) {
      if (_message.text.trim() != '') {
        _message.text = _message.text;
        messagesModel.message = _message.text;
        messagesModel.isActive = true;
        messagesModel.isDelete = false;
        messagesModel.createdAt = DateTime.now();
        messagesModel.updatedAt = DateTime.now();
        messagesModel.isRead = false;
        messagesModel.userId1 = widget.storeId.toString();
        messagesModel.userId2 = widget.userId.toString();
        messagesModel.url = "";
        _message.clear();

        await uploadMessage(
          widget.chatId,
          widget.userId.toString(),
          messagesModel,
        );
        setState(() {
          isDone = false;
          isAlreadyChat = true;
        });

        await callOnFcmApiSendPushNotifications(
          userToken: [widget.userFcmToken],
          title: "new message from Store",
          body: "${messagesModel.message}",
          route: "chatlist_screen",
          chatId: widget.chatId,
          firstName: widget.name,
          lastName: '',
          storeId: widget.storeId.toString(),
          userId: widget.userId.toString(),
          imageUrl: '',
        );
        log("noti");
      }
    }
  }

  Future uploadMessage(
    String? idUser,
    String userId,
    MessagesModel anonymous,
  ) async {
    try {
      final String globalId = widget.storeId.toString();

      final refMessages = chatsCollectionRef
          .doc(idUser)
          .collection('userschat')
          .doc(globalId)
          .collection('messages');
      final refMessages1 = chatsCollectionRef
          .doc(idUser)
          .collection('userschat')
          .doc(userId)
          .collection('messages');
      final newMessage1 = anonymous;
      final newMessage2 = anonymous;

      var messageResult =
          await refMessages.add(newMessage1.toJson()).catchError((e) {
        print('send mess exception' + e);
      });
      newMessage2.isRead = true;
      var message1Result =
          await refMessages1.add(newMessage2.toJson()).catchError((e) {
        print('send mess exception' + e);
      });

      return {
        'user1': messageResult.id,
        'user2': message1Result.id,
      };
    } catch (err) {
      print('uploadMessage err $err');
    }
  }

  Future<dynamic> addUserChat(ChatModel userChat) async {
    try {
      String? result;
      userChat.lastMessageTime = new DateTime.now();
      await db.collection("userchat").add(userChat.toJson()).whenComplete(() {
        result = 200.toString();
      }).catchError((e) {
        print("Exception - addUserChat(): " + e.toString());
        result = e.toString();
      });
      return result;
    } catch (e) {
      print("Exception - addUserChat(): " + e.toString());
    }
  }

  Stream<List<MessagesModel>>? getChatMessages(
      String? idUser, String globalId) {
    try {
      return FirebaseFirestore.instance
          .collection('chats/$idUser/userschat')
          .doc(globalId)
          .collection('messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(MessagesModel.fromJson));
    } catch (err) {
      print("Exception - chat_info.dart - getChatMessages()" + err.toString());
      return null;
    }
  }

  Future<EmailExist> checkUserChatExist(String userId1, String userId2) async {
    EmailExist isExist = new EmailExist();

    try {
      dynamic userChat;
      ChatModel? chat = new ChatModel();
      userChat = await userChatCollectionRef
          .where('userId1', isEqualTo: userId1.toString())
          .where('userId2', isEqualTo: userId2.toString())
          .limit(1)
          .snapshots()
          .transform(Utils.transformer(ChatModel.fromJson))
          .first;
      chat = userChat.isNotEmpty ? userChat[0] : null;
      if (chat != null && chat.chatId != null) {
        isExist = EmailExist(id: chat.chatId, isEMailExist: true);
      } else {
        userChat = await userChatCollectionRef
            .where('userId1', isEqualTo: userId2.toString())
            .where('userId2', isEqualTo: userId1.toString())
            .limit(1)
            .snapshots()
            .transform(Utils.transformer(ChatModel.fromJson))
            .first;
        chat = userChat.isNotEmpty ? userChat[0] : null;
        if (chat != null && chat.chatId != null) {
          isExist = EmailExist(id: chat.chatId, isEMailExist: true);
        } else {
          isExist = EmailExist(id: null, isEMailExist: false);
        }
      }
    } catch (err) {
      print("Exception - checkEmailExist(): " + err.toString());
    }
    return isExist;
  }

  Future<String?> retriveChatUser(String userId1, String userId2) async {
    String? result;
    try {
      QuerySnapshot querySnapshot = await userChatCollectionRef
          .where('userId1', isEqualTo: userId1)
          .where('userId2', isEqualTo: userId2)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userChatCollectionRef
            .doc(querySnapshot.docs[0].id)
            .update({"user2Delete": false});
      } else {
        QuerySnapshot querySnapshot1 = await userChatCollectionRef
            .where('userId1', isEqualTo: userId2)
            .where('userId2', isEqualTo: userId1)
            .limit(1)
            .get();
        if (querySnapshot1.docs.isNotEmpty) {
          userChatCollectionRef
              .doc(querySnapshot1.docs[0].id)
              .update({"user1Delete": false});
        }
      }
    } catch (err) {
      result = 400.toString();
      print("Exception - deleteChatUser(): " + err.toString());
    }
    return result;
  }

  Future<void> updateLastMessageTime(String chatId) async {
    try {
      await db
          .collection("userchat")
          .where("chatId", isEqualTo: chatId)
          .get()
          .then((snapshoe) {
        db.collection("userchat").doc(snapshoe.docs[0].id).update(
            {"lastMessageTime": Utils.fromDateTimeToJson(DateTime.now())});
      });
    } catch (e) {
      print("Exception - updateLastMessageTime(): " + e.toString());
    }
  }

  // Future<bool> callOnFcmApiSendPushNotifications(
  //     {List<String?>? userToken,
  //     String? title,
  //     String? body,
  //     String? route,
  //     String? storeId,
  //     String? userId,
  //     String? imageUrl,
  //     String? chatId,
  //     String? firstName,
  //     String? lastName}) async {
  //   final data = {
  //     "registration_ids": userToken,
  //     "notification": {
  //       "title": '$title',
  //       "body": '$body',
  //       "sound": "default",
  //       "color": "#ff3296fa",
  //       "vibrate": "300",
  //       "priority": 'high',
  //     },
  //     "android": {
  //       "priority": 'high',
  //       "notification": {
  //         "sound": 'default',
  //         "color": '#ff3296fa',
  //         "clickAction": 'FLUTTER_NOTIFICATION_CLICK',
  //         "notificationType": '52',
  //       },
  //     },
  //     "data": {
  //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //       "storeId": '$storeId',
  //       "route": '$route',
  //       "userId": '$userId',
  //       "imageUrl": '$imageUrl',
  //       "chatId": '$chatId',
  //       "firstName": '$firstName',
  //       "lastName": '$lastName',
  //     }
  //   };
  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'key=AAAAUflnTFM:APA91bENvJ_m7EYr0iyqcolGcB3DdSV_K5tKBDOJherPDN0TlQsYNeUzS92HSz0Ou1c_d0ty2Mvp_XAcxYMhqdh0XQG57cMC_8P2N_lFZmZQT55EZ2sfAx_d84ztVMYHGWaUfYwD-vQN' // 'key=YOUR_SERVER_KEY'
  //   };
  //   final response = await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       body: json.encode(data),
  //       encoding: Encoding.getByName('utf-8'),
  //       headers: headers);
  //   if (response.statusCode == 200) {
  //     // on success do sth
  //     print('Send');
  //     return true;
  //   } else {
  //     print('Error');
  //     // on failure do sth
  //     return false;
  //   }
  // }

  Future<bool> callOnFcmApiSendPushNotifications(
      {List<String?>? userToken,
      String? title,
      String? body,
      String? route,
      String? imageUrl,
      String? chatId,
      String? firstName,
      String? lastName,
      String? storeId,
      String? userId,
      String? globalUserToken}) async {
    final data = {
      "registration_ids": userToken,
      "notification": {
        "title": '$title',
        "body": '$body',
        "sound": "default",
        "color": "#ff3296fa",
        "vibrate": "300",
        "priority": 'high',
      },
      "android": {
        "priority": 'high',
        "notification": {
          "sound": 'default',
          "color": '#ff3296fa',
          "clickAction": 'FLUTTER_NOTIFICATION_CLICK',
          "notificationType": '52',
        },
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "storeId": '$storeId',
        "route": '$route',
        "imageUrl": '$imageUrl',
        "chatId": '$chatId',
        "firstName": '$firstName',
        "lastName": '$lastName',
        "userId": '$userId',
        "userToken": globalUserToken
      }
    };
    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAUflnTFM:APA91bENvJ_m7EYr0iyqcolGcB3DdSV_K5tKBDOJherPDN0TlQsYNeUzS92HSz0Ou1c_d0ty2Mvp_XAcxYMhqdh0XQG57cMC_8P2N_lFZmZQT55EZ2sfAx_d84ztVMYHGWaUfYwD-vQN' // 'key=YOUR_SERVER_KEY'
    };
    final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
    if (response.statusCode == 200) {
      // on success do sth
      print('Send');
      return true;
    } else {
      print('Error');
      // on failure do sth
      return false;
    }
  }
}
