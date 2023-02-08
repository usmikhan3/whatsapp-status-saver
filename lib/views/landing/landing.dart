import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_saver/providers/bottom_nav_provider.dart';
import 'package:whatsapp_saver/views/bottonNavPages/image/image_tab.dart';
import 'package:whatsapp_saver/views/bottonNavPages/video/video_tab.dart';
import 'package:whatsapp_saver/widgets/custom_drawer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List<Widget> pages = [
    const ImageTab(),
    const VideoTab(),
  ];









  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
        builder: (context, nav, child) => Scaffold(

          appBar: AppBar(
            backgroundColor: Color(0xFFfcb900).withOpacity(0.5),
            elevation: 0,
            centerTitle: true,
            title: const Text("Story Saver",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "mochiy",
                color: Colors.black
            ),
            ),
            iconTheme:const  IconThemeData(color: Colors.black),

          ),
              drawer: CustomDrawer(),
              body: pages[nav.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const  Color(0xFFfcb900).withOpacity(0.5),
                elevation: 0,
                currentIndex: nav.currentIndex,
                selectedFontSize: 18,
                selectedItemColor: Colors.black,
                selectedLabelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "mochiy",
                  color: Colors.black
                ),
                unselectedFontSize: 16,
                unselectedLabelStyle:  const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "mochiy",
                    color: Colors.black
                ),


                onTap: (value){
                  nav.changeIndex(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.image,size: 25,color: Colors.amber,),
                    label: "Images",
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.video_call,size: 25,color: Colors.amber,),
                    label: "Videos",
                  ),
                ],
              ),
            ));
  }
}
