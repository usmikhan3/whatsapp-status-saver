import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class ImageView extends StatefulWidget {

  final String imagePath;
  const ImageView({Key? key,required this.imagePath}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {

  List<Widget> buttonList = const[
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: FileImage(File(widget.imagePath),),
              
          ),
        ),
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(buttonList.length, (index) {
            return FloatingActionButton(
                heroTag: "$index",
                onPressed: () async{
                  switch(index){
                    case 0:
                      log("download image");
                      await ImageGallerySaver.saveFile(widget.imagePath).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Image saved to gallery"),),
                        );
                      });
                      break;
                    case 1:
                      log("print image");
                      FlutterNativeApi.printImage(widget.imagePath, widget.imagePath.split("/").last);
                      break;
                    case 2:
                      log("share image");
                      FlutterNativeApi.shareImage(widget.imagePath);
                      break;
                  }
                },
                child: buttonList[index]);
          }),
        ),
      ),
    );
  }
}
