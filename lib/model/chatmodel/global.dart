import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/screens/Chat/local_notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

String imageUploadMessageKey = 'w0daAWDk81';
LocalNotification localNotificationModel = new LocalNotification();
bool isChatNotTapped = false;
var uid = FirebaseAuth.instance.currentUser!.uid;
var trainId = FirebaseFirestore.instance
    .collection("training")
    .where("uid", isEqualTo: "EyBMn06XEWdki67sA48odJWAJOt2");
var TID = "EyBMn06XEWdki67sA48odJWAJOt2";
