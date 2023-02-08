import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String? videoPath;

  const VideoView({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttonList = const [
    Icon(Icons.download),
    Icon(Icons.share),
  ];

  ChewieController? _chewieController;


  //TODO: BANNER AD
  late BannerAd bannerAd;
  var adUnitId = "ca-app-pub-8902708450041638/4424297293"; //testADID

  bool isAdLoaded = false;

  initBannerAd() async {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad,error){
          ad.dispose();
          print(error);
        },


      ),
      request: AdRequest(

      ),
    );

    bannerAd.load();
  }


  //TODO: INTERSTITIAL AD
  late InterstitialAd interstitialAd;
  var interstitialId = "ca-app-pub-8902708450041638/8164231751";

  bool isAdInterstitialLoaded = true;

  initInterstitialAd() {
    InterstitialAd.load(

      adUnitId: interstitialId,
      request: AdRequest(),

      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad){
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: ((error){
          interstitialAd.dispose();
          print(error);
        }),

      ),

    );
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(
          widget.videoPath!,
        ),
      ),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 5/6,
      errorBuilder: ((context,errorMessage){
        return  Center(
          child: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "mochiy",
            ),
          ),
        );
      })
    );
    initInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Chewie(
              controller: _chewieController!,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(buttonList.length, (index) {
            return FloatingActionButton(
                heroTag: "$index",
                onPressed: ()async{
                  switch (index) {
                    case 0:
                      log("download video");
                      await ImageGallerySaver.saveFile(widget.videoPath!).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Video saved to gallery"),),
                        );
                        Future.delayed(const Duration(seconds: 1,),(){
                          interstitialAd.show();
                        });
                      });
                      break;
                    case 1:
                      log("share video");
                      FlutterNativeApi.shareImage(widget.videoPath);
                      Future.delayed(const Duration(seconds: 1,),(){
                        interstitialAd.show();
                      });
                      break;
                  }
                },
                child: buttonList[index]);
          }),
        ),
      ),

      bottomNavigationBar: Container(
        height:  bannerAd.size.height.toDouble(),
        color: Colors.black,
        child: isAdLoaded ? SizedBox(
          height: bannerAd.size.height.toDouble(),
          width: bannerAd.size.width.toDouble(),
          child: AdWidget(ad: bannerAd,),
        ) :const  SizedBox(),
      ),
    );
  }
}
