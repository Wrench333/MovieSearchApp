import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_search_app/Models/currentMovies_model.dart';
import 'package:movie_search_app/UI/home_page.dart';

import 'Data Storage and API Calls/firebase_options.dart';
import 'Logic/mediator.dart';
import 'UI/details_page.dart';
import 'UI/favourite_page.dart';
import 'UI/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Failed to initialize Firebase App: $e");
  }
  runApp(ProviderScope(child: MyApp()));
}

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    path: '/mediator',
    builder: (context, state) => Mediator(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/details',
    builder: (context, state) => DetailsPage(),
  ),
  GoRoute(
    path: '/fav',
    builder: (context, state) => FavouritePage(),
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'The Movie Searcher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}


final idStateProvider = StateProvider<String>((ref) {
  return '';
});

final favouriteStateProvider = StateProvider<List<CurrentMovies>>((ref) {
  return [];
});
