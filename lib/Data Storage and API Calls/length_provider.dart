import 'package:flutter/cupertino.dart';

class LengthProvider extends ChangeNotifier {
  String _length = '';
  String get id => _length;

  void lengthUpdate(String length) {
    _length = length;
  }
}