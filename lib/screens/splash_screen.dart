

import 'dart:async';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import './login_screen.dart';

class splashScreen extends StatefulWidget{

  @override

  State<StatefulWidget> createState() => InitState();

  }

class InitState extends State<splashScreen>{
  @override
   InitState(){
    super.initState();
startTimer();
  }
  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, loginRoute);

  }

  loginRoute(){
    Navigator.pushReplacement(context, MaterialPageRoute (
builder: (context) => LoginScreen(),
    ));
  }
@override 
   Widget build(BuildContext context){
   return initWidget();
   }


  Widget initWidget(){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 4, 72, 77),
              gradient: LinearGradient(
                colors:[(Color.fromARGB(255, 4, 72, 77)),(Color.fromARGB(255, 9, 90, 100))],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
                 )
            ),

          ),
          
          // Center(
          //   child: Container(
          //     child: const Image(image: NetworkImage('https://www.seekpng.com/png/detail/163-1634804_clipart-colorful-camera-shutter-png.png'),)
          //   )
          
          // )
        ],
      ),
    );
   }



}