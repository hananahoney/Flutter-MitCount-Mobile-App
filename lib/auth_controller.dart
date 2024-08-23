import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tflite_image_classification/login.dart';
import 'package:tflite_image_classification/splashscreen.dart';
import 'TfliteModel.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  //contains email, password, name...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }


  _initialScreen(User? user){

    Get.offAll(()=>SplashScreen());
    
    if(user==null){
      
      print("login page");
      Get.offAll(()=>Login());
    }
    else{
      Get.offAll(()=>TfliteModel());
    }
  }

  void register(String email, String password, String fName, String lName, String url)async{

    

    if(fName != "" && lName != "" && email != "" && password != ""){
      try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        'uid':user.uid,
        'email':email,
        'fName':fName,
        'lName':lName,
        'url':url,
      });
    }catch(e){
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.pinkAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Account creation failed",
        style: TextStyle(
          color: Colors.white
        ),
      ),
      messageText: Text(
        e.toString(),
        style: TextStyle(
          color: Colors.white
        ),
      )
      );
    }
    }
    else if(fName == ""){
      Fluttertoast.showToast(msg: "Please Enter your first Name");

    }
    else if(lName == ""){
      Fluttertoast.showToast(msg: "Please Enter your last Name");
    }
    else if(email == ""){
      Fluttertoast.showToast(msg: "Please Enter your Email");

    }
    else if(password == ""){
      Fluttertoast.showToast(msg: "Please Enter your Password");

    }

    
  }

  void login(String email, password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      
    }catch(e){
      Get.snackbar("About Login", "Login message",
      backgroundColor: Colors.pinkAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Login failed",
        style: TextStyle(
          color: Colors.white
        ),
      ),
      messageText: Text(
        e.toString(),
        style: TextStyle(
          color: Colors.white
        ),
      )
      );
    }
  }

  void logot(){
    auth.signOut();
  }

  Future<String?> registerwithGoogle() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      final GoogleSignInAccount ? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e){
      print(e.message);
      throw e;
    }
  }

}