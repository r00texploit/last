import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:details/widget/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
// import 'package:vendor/Components/drawer.dart';
// import 'package:vendor/Locale/locales.dart';
import 'package:details/screens/Chat/chat_info.dart';
import 'package:details/screens/Chat/chat_store.dart';
// import 'package:vendor/baseurl/baseurlg.dart' as baseUrl;
import 'package:details/model/chatmodel/global.dart' as global;
// import 'package:details/model/revenue/topselling.dart';

class Chat {
  Chat(this.img, this.name, this.sold, this.price);

  String img;
  String name;
  String sold;
  String price;
}

class ChatListPage extends StatefulWidget with WidgetsBindingObserver {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<ChatStore> _stores = [];
  var http = Client();

  // List<TopSellingItemsR> topSellingItems = [];
  // TopSellingRevenueOrdCount? orderCount;
  bool isLoading = false;
  dynamic apCurrency;

  String storeImage = '';

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var trainId = FirebaseAuth.instance.currentUser!.uid;
    setState(() {
      isLoading = true;
    });
    await retriveChatUser(trainId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  Future<String?> retriveChatUser(String trainId) async {
    String? result;
    try {
      try {
        List<QueryDocumentSnapshot> sd = (await FirebaseFirestore.instance
                .collectionGroup('chat')
                .where('trainId', isEqualTo: trainId)
                .orderBy("updatedAt", descending: true)
                .get())
            .docs
            .toList();
        sd.forEach((e) {
          setState(() {
            _stores.add(ChatStore.fromJson(e.data() as Map<String, dynamic>));
          });
          print(e.data().toString());
        });

        print("");
      } catch (err) {
        print("Exception - deleteChatUser(): " + err.toString());
      }
    } catch (err) {
      result = 400.toString();
      print("Exception - deleteChatUser(): " + err.toString());
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        drawer: buildDrawer(context),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              "chat",
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: (!isLoading)
                  ? _stores.length > 0
                      ? ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          shrinkWrap: true,
                          itemCount: _stores.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatInfo(
                                                chatId: _stores[index].chatId,
                                                name: _stores[index].name,
                                                storeId: _stores[index].storeId,
                                                userFcmToken:
                                                    _stores[index].userFcmToken,
                                                userId: _stores[index].userId,
                                              )));
                                },
                                child:
                                    buildChatListCard(context, _stores[index]));
                          })
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: const Text('No chats found'),
                          ),
                        )
                  // : Align(
                  //     alignment: Alignment.center,
                  //     child: Text(locale.nohistoryfound),
                  //   )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return buildTopSellingSHItemCard();
                      }),
            ),
            //Positioned.directional(textDirection: Directionality.of(context), top: 130, start: 0, end: 0, child: (!isLoading) ? buildOrderCard(context, orderCount) : buildOrderSHCard()),
          ],
        ),
      ),
    );
  }

  Container buildOrderCard(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400]!,
            blurRadius: 0.0, // soften the shadow
            spreadRadius: 0.5, //extend the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: <TextSpan>[
                  // TextSpan(
                  //     text: '${}\n',
                  //     style: Theme.of(context).textTheme.subtitle2),
                  // TextSpan(
                  //     text: (orderCount.totalOrders != null)
                  //         ? '${orderCount.totalOrders}'
                  //         : '',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .subtitle1!
                  //         .copyWith(height: 2)),
                ])),
            VerticalDivider(
              color: Colors.grey[400],
            ),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: <TextSpan>[
                  // TextSpan(
                  //     text: '${locale.revenue}\n',
                  //     style: Theme.of(context).textTheme.subtitle2),
                  // TextSpan(
                  //     text: (orderCount.totalRevenue != null)
                  //         ? '$apCurrency ${orderCount.totalRevenue!.toStringAsFixed(2)}'
                  //         : '$apCurrency 0.0',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .subtitle1!
                  //         .copyWith(height: 2)),
                ])),
            VerticalDivider(
              color: Colors.grey[400],
            ),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(children: <TextSpan>[
                  // TextSpan(
                  //     text: '${locale.pending}\n',
                  //     style: Theme.of(context).textTheme.subtitle2),
                  // TextSpan(
                  //     text: (orderCount.pendingOrders != null)
                  //         ? '${orderCount.pendingOrders}'
                  //         : '0',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .subtitle1!
                  //         .copyWith(height: 2)),
                ])),
          ],
        ),
      ),
    );
  }

  Widget buildOrderSHCard() {
    return Shimmer(
      duration: const Duration(seconds: 3),
      color: Colors.white,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400]!,
              blurRadius: 0.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.grey[400],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.grey[400],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 10,
                    width: 60,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildChatListCard(BuildContext context, ChatStore stores) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                // child: stores.userProfileImageUrl != null
                //     ? CachedNetworkImage(
                //         width: MediaQuery.of(context).size.width,
                //         height: 230,
                //         imageUrl: baseUrl.imagebaseUrl +
                //             '${stores.userProfileImageUrl}',
                //         fit: BoxFit.fill,
                //         placeholder: (context, url) => Align(
                //           widthFactor: 50,
                //           heightFactor: 50,
                //           alignment: Alignment.center,
                //           child: Container(
                //             padding: const EdgeInsets.all(5.0),
                //             width: 50,
                //             height: 50,
                //             child: const CircularProgressIndicator(),
                //           ),
                //         ),
                //         errorWidget: (context, url, error) => Image.asset(
                //           'assets/icon.png',
                //           fit: BoxFit.fill,
                //         ),
                //       )
                //     : Container(
                //         child: Icon(
                //         Icons.person,
                //         color: Theme.of(context).textTheme.subtitle2!.color,
                //       ))),
                // const SizedBox(
                //   width: 10,
                // ),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.subtitle1,
                              children: <TextSpan>[
                            TextSpan(text: '${stores.name}'),
                            //TextSpan(text: '${locale.apparel}\n\n', style: Theme.of(context).textTheme.subtitle2),
                          ])),
                      stores.lastMessage != global.imageUploadMessageKey
                          ? Text('${stores.lastMessage}',
                              style: Theme.of(context).textTheme.subtitle2)
                          : Row(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .color,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text('Photo',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTopSellingSHItemCard() {
    return Shimmer(
      duration: const Duration(seconds: 3),
      color: Colors.white,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.grey[300],
                    )),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
