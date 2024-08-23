import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'auth_controller.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), (){
      WidgetsFlutterBinding.ensureInitialized();
      Firebase.initializeApp().then((value)=>Get.put(AuthController()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Column(
        children: [
          Container( 
            width: w,
            height: h*0.9,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'),
              alignment: Alignment.center,
              )
            ),
          ),
         Text(
              "MitCount",
              style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
         ),
        ],
      ),
    );
  }
}