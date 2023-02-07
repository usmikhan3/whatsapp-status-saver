import 'package:flutter/material.dart';


class BottomNavBarProvider extends ChangeNotifier{


  int _currentIndex = 0;

  int get currentIndex => _currentIndex;


  void changeIndex(int value){
    _currentIndex = value;
    notifyListeners();
  }



}