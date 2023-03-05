import 'package:details/widget/button_style.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:details/widget/cartappBarr.dart';

class PTSD extends StatelessWidget {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  // var list = [
  //   ["", "", ""],
  //   ["", "", ""],
  //   ["", "", ""],
  //   ["", "", ""]
  // ];
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        CartAppBar(),
        Container(
          height: 800,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          child: Column(
            children: [
              
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: ExpansionTileCard(
                  baseColor: Colors.cyan[50],
                  expandedColor: Colors.red[50],
                  key: cardA,
                  leading: CircleAvatar(
                      child: Image.asset("assets/image/down.jpg")),
                  title: Text("ما هو اضرابما بعد الصدمة؟"),
                  subtitle: Text("هو مرض نفسي ناتج عن .."),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "FlutterDevs specializes in creating cost-effective and efficient applications with our perfectly crafted,"
                          " creative and leading-edge flutter app development solutions for customers all around the globe.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      buttonHeight: 52.0,
                      buttonMinWidth: 90.0,
                      children: <Widget>[
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            cardA.currentState?.expand();
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.arrow_downward),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Open'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            cardA.currentState?.collapse();
                          },
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.arrow_upward),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Close'),
                            ],
                          ),
                        ),
                        TextButton(
                          style: flatButtonStyle,
                          onPressed: () {},
                          child: Column(
                            children: const <Widget>[
                              Icon(Icons.swap_vert),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text('Toggle'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              //   child: ExpansionTileCard(
              //     baseColor: Colors.cyan[50],
              //     expandedColor: Colors.red[50],
              //     key: cardA,
              //     leading: CircleAvatar(
              //         child: Image.asset("assets/image/avatar-1.png")),
              //     title: Text("2 ما هو اضرابما بعد الصدمة؟"),
              //     subtitle: Text("هو مرض نفسي ناتج عن .."),
              //     children: <Widget>[
              //       Divider(
              //         thickness: 1.0,
              //         height: 1.0,
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 16.0,
              //             vertical: 8.0,
              //           ),
              //           child: Text(
              //             "FlutterDevs specializes in creating cost-effective and efficient applications with our perfectly crafted,"
              //             " creative and leading-edge flutter app development solutions for customers all around the globe.",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText2
              //                 ?.copyWith(fontSize: 16),
              //           ),
              //         ),
              //       ),
              //       ButtonBar(
              //         alignment: MainAxisAlignment.spaceAround,
              //         buttonHeight: 52.0,
              //         buttonMinWidth: 90.0,
              //         children: <Widget>[
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {
              //               cardA.currentState?.expand();
              //             },
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.arrow_downward),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Open'),
              //               ],
              //             ),
              //           ),
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {
              //               cardA.currentState?.collapse();
              //             },
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.arrow_upward),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Close'),
              //               ],
              //             ),
              //           ),
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {},
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.swap_vert),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Toggle'),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              //   child: ExpansionTileCard(
              //     baseColor: Colors.cyan[50],
              //     expandedColor: Colors.red[50],
              //     key: cardA,
              //     leading: CircleAvatar(
              //         child: Image.asset("assets/image/avatar-1.png")),
              //     title: Text("3 ما هو اضرابما بعد الصدمة؟"),
              //     subtitle: Text("هو مرض نفسي ناتج عن .."),
              //     children: <Widget>[
              //       Divider(
              //         thickness: 1.0,
              //         height: 1.0,
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //             horizontal: 16.0,
              //             vertical: 8.0,
              //           ),
              //           child: Text(
              //             "FlutterDevs specializes in creating cost-effective and efficient applications with our perfectly crafted,"
              //             " creative and leading-edge flutter app development solutions for customers all around the globe.",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyText2
              //                 ?.copyWith(fontSize: 16),
              //           ),
              //         ),
              //       ),
              //       ButtonBar(
              //         alignment: MainAxisAlignment.spaceAround,
              //         buttonHeight: 52.0,
              //         buttonMinWidth: 90.0,
              //         children: <Widget>[
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {
              //               cardA.currentState?.expand();
              //             },
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.arrow_downward),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Open'),
              //               ],
              //             ),
              //           ),
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {
              //               cardA.currentState?.collapse();
              //             },
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.arrow_upward),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Close'),
              //               ],
              //             ),
              //           ),
              //           TextButton(
              //             style: flatButtonStyle,
              //             onPressed: () {},
              //             child: Column(
              //               children: const <Widget>[
              //                 Icon(Icons.swap_vert),
              //                 Padding(
              //                   padding: EdgeInsets.symmetric(vertical: 2.0),
              //                 ),
              //                 Text('Toggle'),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ));
  }
}
