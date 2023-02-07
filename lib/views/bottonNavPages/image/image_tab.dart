import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_saver/providers/get_status_provider.dart';
import 'package:whatsapp_saver/views/bottonNavPages/image/image_view.dart';

import 'package:whatsapp_saver/views/landing/landing.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({Key? key}) : super(key: key);

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusesProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".jpg");
          Future.delayed(const Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }

        return file.isWhatsappAvailable == false
            ? const Center(
                child: Text(
                  "Whatsapp not available :( ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "mochiy",
                  ),
                ),
              )
                  : file.getImages.isEmpty ?
              const Center(
                child: Text(
                  "No Images Found :( ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "mochiy",
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.all(8),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  children: List.generate(file.getImages.length, (index) {
                    final data = file.getImages[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) =>  ImageView(
                              imagePath: data.path,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(data.path,),),
                            fit: BoxFit.cover
                          ),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }),
                ),
              );
      }),
    );
  }
}
