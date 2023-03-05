import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/model/chatmodel/messageModel.dart';
import 'package:details/screens/Chat/stream_formatter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../chatmodel/global.dart' as global;

class APIHelper {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference userChatCollectionRef =
      FirebaseFirestore.instance.collection("chats");
  CollectionReference trainCollectionRef =
      FirebaseFirestore.instance.collection("train");

  String? url;

  

  Stream<List<MessagesModel>>? getChatMessages(
      String? idUser, String globalId) {
    try {
      return FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          // userschat')
          // .doc(globalId)
          // .collection('messages')
          .orderBy("createdAt", descending: true)
          .snapshots()
          .transform(StreamFormatter.transformer(MessagesModel.fromJson));
    } catch (err) {
      print("Exception - apiHelper.dart - getChatMessages()" + err.toString());
      return null;
    }
  }

  
  
  Future updateImageMesageURL(
      String? chatId, String userId, String? messageId, String url) async {
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
      print('Exception - updateImageMesageURL(): ${err.toString()}');
    }
  }

  Future<String?> uploadImageToStorage(File image, String? chatId,
      String userid, MessagesModel anonymous) async {
    try {
      log(anonymous.id.toString());
      var messageR = await uploadMessage(chatId, userid, anonymous, false, '');
      var fileName = DateTime.now().microsecondsSinceEpoch.toString();
      var refImg = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = refImg.putFile(image);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      await updateImageMesageURL(
          chatId, global.uid.toString(), messageR['user1'], imageUrl);
      await updateImageMesageURL(chatId, userid, messageR['user2'], imageUrl);

      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future uploadMessage(String? idUser, String userId, MessagesModel anonymous,
      bool isAlreadychat, String imageUrl) async {
    try {
      final String globalId = global.uid.toString();
      // if (!isAlreadychat && userChat.chatId != null) {}
      final refMessages = userChatCollectionRef
          .doc(idUser)
          // .collection('userschat')
          // .doc(globalId)
          .collection('messages');
      final refMessages1 = userChatCollectionRef
          .doc(userId)
          // .collection('userschat')
          // .doc(userId)
          .collection('messages');
      final newMessage1 = anonymous;

      final newMessage2 = anonymous;

      var messageResult =
          await refMessages.add(newMessage1.toJson()).catchError((e) {
        print('send mess exception' + e);
      });
      newMessage2.isRead = false;
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
}

class EmailExist {
  String? id;
  bool? isEMailExist;
  EmailExist({this.id, this.isEMailExist});
}
