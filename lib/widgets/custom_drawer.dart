import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.6,

      child: SafeArea(
        child: Drawer(

          child: Container(
            color:  const  Color(0xFFfcb900).withOpacity(0.5),
            child: Column(
              children:  [
                      ListTile(
                        onTap: ()async {
                          const url = 'https://www.softnoxtechnologies.com/about-us/';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        title:  const Text("Rate us",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "mochiy",
                        ),
                        ),
                        trailing: const Icon(Icons.star_outline),
                      ),
                ListTile(
                  onTap: ()async {
                    const url = 'https://www.softnoxtechnologies.com/about-us/';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  title:  const Text("About us",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "mochiy",
                  ),
                  ),
                  trailing: const Icon(Icons.info_outline),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
