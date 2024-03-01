import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleLogin = Provider<GoogleSignInProvider>((ref) => GoogleSignInProvider());

final googleSignInProvider = StateProvider<Future>((ref) async {
  ref.watch(GoogleLogin).googleLogin();
  return ;
});

final googleSignOutProvider = StateProvider<Future>((ref) async {
  ref.watch(GoogleLogin).logout();
  return ;
});

class GoogleSignInProvider{

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      print('Login Process Started');
      final googleUser = await googleSignIn.signIn();
      if(googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('Login Process Ended');
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('logged in');
    }  catch (e) {
      print("Error: $e");
    }
  }

  Future logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      _user = null;
      print('Sign-out successful');
    } catch (e) {
      print('Sign-out failed: $e');
    }
  }
}