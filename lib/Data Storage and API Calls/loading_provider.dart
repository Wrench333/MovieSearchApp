import 'package:flutter/cupertino.dart';

class IdProvider extends ChangeNotifier {
  String _id = '';
  String get id => _id;

  void idUpdate(String id) {
    _id = id;
  }
}