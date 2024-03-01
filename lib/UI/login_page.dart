import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/google_sign_in.dart';
import 'package:movie_search_app/UI/home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello! Welcome to the only place to search for Movies ;)',style: TextStyle(fontSize: 25,color: Colors.white),textAlign: TextAlign.center,),
            SizedBox(height: size.height/10,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, size.height/12),
              ),
              icon: FaIcon(FontAwesomeIcons.google,color: Colors.red,),
              onPressed: () async {
                print('Button Pressed');
                await ref.watch(googleSignInProvider);
                context.go('/mediator');
              },
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign  Up with Google',style: TextStyle(fontSize: 20),),
              ),
            )
          ],
        ),
      ),
    );
  }
}