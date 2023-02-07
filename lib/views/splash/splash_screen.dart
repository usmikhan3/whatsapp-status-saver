import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_saver/views/landing/landing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (_) =>const  LandingScreen(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // Image.asset("assets/logo.png"),

            Image.asset("assets/loader.gif",height: 100,),

            const SizedBox(height: 20,),


            const Text("Whatsapp Saver",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "mochiy",

            ),),




          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 80,

        child:  Center(
          child:   Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
              Text("Created By: ",
                style: TextStyle(

                  fontWeight: FontWeight.bold,
                  fontFamily: "mochiy",

                ),),
              Text("Softnox Technologies",
                style: TextStyle(
                    color: Color(0xFFfcb900),
                  fontWeight: FontWeight.bold,
                  fontFamily: "mochiy",

                ),),
            ],
          ),
        ),
      ),
    );
  }
}
