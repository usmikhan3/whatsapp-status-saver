import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageView extends StatefulWidget {
  final String imagePath;
  const ImageView({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttonList = const [
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];


  //TODO: BANNER AD
  late BannerAd bannerAd;
  var adUnitId = "ca-app-pub-3940256099942544/6300978111"; //testADID

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
  var interstitialId = "ca-app-pub-3940256099942544/1033173712";

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
    initInterstitialAd();


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            interstitialAd.show();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: FileImage(
                  File(widget.imagePath),
                ),
                fit: BoxFit.contain
              ),
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
                onPressed: () async {
                  switch (index) {
                    case 0:
                      log("download image");
                      await ImageGallerySaver.saveFile(widget.imagePath)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Image saved to gallery"),
                          ),
                        );
                        interstitialAd.show();
                      });
                      break;
                    case 1:
                      log("print image");
                      FlutterNativeApi.printImage(
                          widget.imagePath, widget.imagePath.split("/").last);
                      Future.delayed(const Duration(seconds: 1,),(){
                        interstitialAd.show();
                      });

                      break;
                    case 2:
                      log("share image");
                      FlutterNativeApi.shareImage(widget.imagePath);
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
