import 'package:flutter/cupertino.dart';

class FavouriteProvider extends ChangeNotifier {
  List<String> _titles = [];
  List<String> get titles => _titles;

  void toggleFavourite(String title) {
    final isExist = _titles.contains(title);
    if(isExist){
      _titles.remove(title);
    } else {
      _titles.add(title);
    }
    notifyListeners();
  }

  bool isExist(String title) {
    final isExist = _titles.contains(title);
    return isExist;
  }
}