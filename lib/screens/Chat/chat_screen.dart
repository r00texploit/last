import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:collection/collection.dart";
import 'package:details/model/chatmodel/chatmodel.dart';
import 'package:details/model/chatmodel/messageModel.dart';
import 'package:details/screens/Chat/image_view_screen.dart';
import 'package:details/screens/Chat/size_config.dart';
import 'package:details/widget/toastfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:details/model/chatmodel/global.dart' as global;
import 'package:details/model/chatmodel/apiHelper.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:url_launcher/url_launcher_string.dart';

var apiHelper = APIHelper();

Future updateLastMessage(
    String? trainId, String? userEmail, String? lastMessage) async {
  List<QueryDocumentSnapshot> storeData = (await FirebaseFirestore.instance
          .collectionGroup("chat")
          .where('trainId', isEqualTo: trainId)
          .where('userId', isEqualTo: userEmail)
          .get())
      .docs
      .toList();
  if (storeData.isNotEmpty) {
    FirebaseFirestore.instance
        .collection("center")
        .doc(storeData[0].id)
        .update({
      "lastMessage": lastMessage,
      "lastMessageTime": DateTime.now().toUtc(),
      "updatedAt": DateTime.now().toUtc()
    });
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({a, o});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // APIHelper apiHelper = new APIHelper();
  UserChat userChat = new UserChat();
  bool isDone = false;
  MessagesModel messageModel = new MessagesModel();
  List<MessagesModel>? messages = [];
  TextEditingController _message = new TextEditingController();
  bool isShowSticker = false;
  DateTime _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? chatId;
  File? _tImage;

  bool isAlreadyChat = false;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  bottomChatBar() {
    return Container(
      color: Colors.white,
      height: SizeConfig.blockSizeVertical * 4,
      width: SizeConfig.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 16,
            child: IconButton(
              icon: Image.asset("assets/images/avatar-1.png"),
              iconSize: 40,
              onPressed: () async {
                _showCupertinoModalSheet();
              },
            ),
          ),
          Expanded(
            child: Container(
              child: TextFormField(
                controller: _message,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2),
                  labelText: "Write a Message here ",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF1F1F1F).withOpacity(0.4)),
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        await sendMessage();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    TextTheme textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        if (messages != null &&
            messages!.length > 0 &&
            messages!.first.message != null &&
            messages!.first.message!.isNotEmpty) {
          await updateLastMessage(
              global.TID, global.uid, messages!.first.message);
        }

        Get.back();
        return false;
      },
      child:
          // Scaffold(
          //   key: _scaffoldKey,
          //   backgroundColor: const Color(0xffFDFDFD),
          //   appBar: customAppBar(textTheme),
          //   body:
          LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: StreamBuilder<List<MessagesModel>>(
                    stream: apiHelper.getChatMessages(
                        chatId, global.uid.toString()),
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
                                        bottom:
                                            SizeConfig.blockSizeVertical * 12),
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
                                          MessagesModel m = value.lastWhere(
                                              (e) =>
                                                  e.createdAt
                                                      .toString()
                                                      .substring(0, 10) ==
                                                  key.toString());
                                          messages![messages!.indexOf(m)]
                                              .isShowDate = true;
                                          isDone = true;
                                        });
                                        final message = messages![index];
                                        return _buildMessage(
                                          message,
                                          message.userId1 ==
                                              global.uid.toString(),
                                        );
                                      },
                                    ),
                                  );
                          }
                      }
                    }),
              )
            ],
          ),
        ),
        // ),
        // bottomSheet: Container(
        //   height: SizeConfig.blockSizeVertical * 12,
        //   child: bottomChatBar(),
        // ),
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      );

  customAppBar(TextTheme textTheme) {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical * 10),
      child: Container(
        color: const Color(0xffFDFDFD),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () async {
                  if (messages != null &&
                      messages!.length > 0 &&
                      messages!.first.message != null &&
                      messages!.first.message!.isNotEmpty) {
                    await updateLastMessage(
                        global.TID, global.uid, messages!.first.message);
                  }

                  Get.back();
                },
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Text(
                'ask any questions',
                style: textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // _init();
  }

  launchCaller(String? phone) async {
    String url = "tel:$phone";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sendMessage() async {
    try {
      int? id = Random().nextInt(9999) * 10;
      if (chatId != null) {
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
              chatId, global.TID, messageModel, isAlreadyChat, '');

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
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6),
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
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6),
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

  Future<File?> openCamera() async {
    try {
      PermissionStatus permissionStatus = await Permission.camera.status;
      if (permissionStatus.isLimited || permissionStatus.isDenied) {
        permissionStatus = await Permission.camera.request();
      }
      XFile? _selectedImage = await ImagePicker().pickImage(
          source: ImageSource.camera, maxHeight: 1200, maxWidth: 1200);
      if (_selectedImage != null) {
        File imageFile = File(_selectedImage.path);
        CroppedFile? _finalImage = await _cropImage(imageFile.path);
        if (_finalImage != null) {
          File? _compressedImage =
              await _imageCompress(_finalImage, imageFile.path);

          print("_byteData path ${_compressedImage?.path}");
          return _compressedImage;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Exception - businessRule.dart - openCamera():" + e.toString());
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
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_selectedImage != null) {
        imageFile = File(_selectedImage.path);
        CroppedFile? _byteData = await _cropImage(imageFile.path);
        if (_byteData != null) {
          File? _compressedImage =
              await _imageCompress(_byteData, imageFile.path);
          return _compressedImage;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Exception - businessRule.dart - selectImageFromGallery()" +
          e.toString());
    }
    return null;
  }

  Future<CroppedFile?> _cropImage(String sourcePath) async {
    try {
      CroppedFile? _croppedFile = await ImageCropper().cropImage(
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
          ]);

      return _croppedFile;
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
    }
    return null;
  }

  Future<File?> _imageCompress(CroppedFile file, String targetPath) async {
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath,
        minHeight: 1200,
        minWidth: 1200,
        quality: 50,
      );

      return result;
    } catch (e) {
      print("Exception - businessRule.dart - _cropImage():" + e.toString());
      return null;
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text('actions'),
          actions: [
            CupertinoActionSheetAction(
              key: _scaffoldKey,
              child: Text(
                'take picture ',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
                _tImage = await openCamera();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = global.uid.toString();
                  messageModel.userId2 = global.TID;
                  messageModel.url = "";
                  await apiHelper.uploadImageToStorage(
                      _tImage!, chatId, global.TID.toString(), messageModel);

                  setState(() {});
                }
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'upload image desc',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
                _tImage = await selectImageFromGallery();
                if (_tImage != null) {
                  messageModel.message = global.imageUploadMessageKey;
                  messageModel.isActive = true;
                  messageModel.isDelete = false;
                  messageModel.createdAt = DateTime.now();
                  messageModel.updatedAt = DateTime.now();
                  messageModel.isRead = true;
                  messageModel.userId1 = global.uid.toString();
                  messageModel.userId2 = global.TID;
                  messageModel.url = "";
                  await apiHelper.uploadImageToStorage(
                      _tImage!, chatId, global.TID.toString(), messageModel);

                  setState(() {});
                }
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('cancel',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      debugPrint(
          "Exception - chat_screen.dart - _showCupertinoModalSheet():$e");
    }
  }
}
