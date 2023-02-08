import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_saver/providers/bottom_nav_provider.dart';
import 'package:whatsapp_saver/views/splash/splash_screen.dart';

import 'providers/get_status_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<BottomNavBarProvider>(create: (_)=>BottomNavBarProvider()),
      ChangeNotifierProvider<GetStatusesProvider>(create: (_)=>GetStatusesProvider()),
    ],
    child:const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp Saver',
      home:  SplashScreen(),
    ),);
  }
}

//keytool -genkey -v -keystore c:\Users\USER\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
