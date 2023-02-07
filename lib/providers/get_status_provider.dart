import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_saver/utils/constants.dart';

class GetStatusesProvider extends ChangeNotifier {

  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];


  bool _isWhatsappAvailable = false;


  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;


  bool get isWhatsappAvailable  => _isWhatsappAvailable;




  void getStatus(String ext) async {
    final status = await Permission.storage.request();
    final status1 = await Permission.manageExternalStorage.request();

    if (status.isDenied) {
      Permission.storage.request();
      log("Permission denied");
      return;
    }

    if (status.isGranted && status1.isGranted) {
      final directory = Directory(AppConstants.WHATSAPP_PATH);

      if (directory.existsSync()) {
        final items = directory
            .listSync();



        if(ext == ".mp4"){
          _getVideos = items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        }else{
          _getImages = items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        }

        _isWhatsappAvailable = true;
        notifyListeners();

        print(items.toString());
      } else {
        log("no whatsapp found");
        _isWhatsappAvailable = false;
        notifyListeners();
      }
    }
  }
}
