import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/favourite_provider.dart';
import 'package:movie_search_app/Data%20Storage%20and%20API%20Calls/loading_provider.dart';
import 'package:movie_search_app/UI/home_page.dart';
import 'package:provider/provider.dart';

import 'details_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => Home(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/details',
    builder: (context, state) => DetailsPage(),
  ),
  /*GoRoute(
    path: '/fav',
    builder: (context, state) => FavouritePage(),
  ),*/
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IdProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'The Movie Searcher',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => context.go('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
