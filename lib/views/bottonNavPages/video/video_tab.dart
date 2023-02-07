import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_saver/providers/get_status_provider.dart';
import 'package:whatsapp_saver/utils/get_thumbnails.dart';
import 'package:whatsapp_saver/views/bottonNavPages/video/video_view.dart';

import 'package:whatsapp_saver/views/landing/landing.dart';

class VideoTab extends StatefulWidget {
  const VideoTab({Key? key}) : super(key: key);

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {

  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusesProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".mp4");
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
            "No Videos Found :( ",
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
            children: List.generate(file.getVideos.length, (index) {
              final data = file.getVideos[index];
              return FutureBuilder<String>(
                future: getThumbnail(data.path),
                builder: (context, snapshot) {




                return  snapshot.hasData ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => VideoView(videoPath:data.path,),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(snapshot.data!,),),
                            fit: BoxFit.cover
                          ),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ): const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              );
            }),
          ),
        );
      }),
    );
  }
}
