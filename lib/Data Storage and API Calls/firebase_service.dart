import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> currentUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }
}