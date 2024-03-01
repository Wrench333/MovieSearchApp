import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/UI/home_page.dart';

import '../UI/login_page.dart';

class Mediator extends StatefulWidget {
  const Mediator({super.key});

  @override
  State<Mediator> createState() => _HomeState();
}

class _HomeState extends State<Mediator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong !'),);
            } else if(snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          }),
    );
  }
}