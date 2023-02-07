import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_saver/providers/bottom_nav_provider.dart';
import 'package:whatsapp_saver/views/bottonNavPages/image/image_tab.dart';
import 'package:whatsapp_saver/views/bottonNavPages/video/video_tab.dart';

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
              body: pages[nav.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: nav.currentIndex,
                onTap: (value){
                  nav.changeIndex(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.image),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon:  Icon(Icons.video_call),
                    label: "",
                  ),
                ],
              ),
            ));
  }
}
