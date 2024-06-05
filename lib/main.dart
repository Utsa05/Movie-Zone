import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_zone/bindings/initial-binding.dart';
import 'package:movie_zone/constants/string.dart';
import 'package:movie_zone/constants/theme.dart';
import 'package:movie_zone/presentation/pages/bottom-nav.dart/bottom-nav.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: AppString.appName,
      theme: AppTheme.theme,
      home: const BottomNavPage(),
    );
  }
}
