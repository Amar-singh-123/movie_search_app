import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/views/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetCupertinoApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
     checkerboardRasterCacheImages: false,
      title: 'Movies Search App',
      theme: CupertinoThemeData(
        brightness: Brightness.light,),
      home: SplashScreen(),
    );
  }
}
