import 'package:flutter/material.dart';
import 'package:tflite_image_classification/auth_controller.dart';
import 'package:tflite_image_classification/login.dart';
import 'package:tflite_image_classification/TfliteModel.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tflite_image_classification/login.dart';
import 'package:tflite_image_classification/prac.dart';
import 'package:tflite_image_classification/signup.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tflite_image_classification/splashscreen.dart';
import 'splashscreen.dart';

Future<void> main() async{
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MitCount',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  home: const TfliteModel(),
      home: const SplashScreen(),
      // home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

