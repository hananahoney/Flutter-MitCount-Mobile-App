import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tflite_image_classification/auth_controller.dart';
import 'package:tflite_image_classification/signup.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'TfliteModel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText = true;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool loading = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return (loading)?Scaffold(body:Center(child:CircularProgressIndicator(color: Colors.pinkAccent,)),):Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
        children: [
          Container( 
            width: w,
            height: h*0.35,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'),
              alignment: Alignment.bottomCenter,
              )
            ),
          ),
          Container(
            width: w,
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MitCount",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                  "Sign into your account",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,

                ),
                ),
                SizedBox(height: 30,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ]
                  ),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return ("Please Enter Your Email");
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return ("Please Entera valid email");
                      }
                      return null;
                    },
                    onSaved: (value){
                      //emailController.text = value!;
                    },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email,color: Colors.pinkAccent),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 211, 211, 211),
                        width: 1.0,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 211, 211, 211),
                        width: 1.0,
                      )
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                ),
              
                ),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ]
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    validator:(value){
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if(value!.isEmpty){
                        return ("Please Enter your password");
                      }
                      if(!regex.hasMatch(value)){
                        return ("Please Enter valid password of Min. 6 characters");
                      }
                    },
                    onSaved: (value){
                      //passwordController.text = value!;
                    },
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: InkWell(
                    onTap: _toggle,
                    child: Icon(
                      _obscureText
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                      size: 15.0,
                      color: Colors.pinkAccent
                    ),
                  ),
                    prefixIcon: Icon(Icons.vpn_key,color: Colors.pinkAccent),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 211, 211, 211),
                        width: 1.0,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 211, 211, 211),
                        width: 1.0,
                      )
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                ),
              
                ),
                SizedBox(height:20,),
                Row(
                  children: [
                    Expanded(child: Container(),),
                    RichText(
                  text: TextSpan(
                    text: "Forgot your password?",
                  style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  ),

                ),
                ),
                
                  ],
                ),
                SizedBox(height:20,),
                Container(
                  width: w,
                  height: 50,
                  margin: EdgeInsets.only(left: 70,right: 70,bottom: 0,top: 20),
                  child : MaterialButton(
                      child :Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20),) ,
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      onPressed:() {
                        
                          AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                        

                      },
                  ),
          ),
              SizedBox(height:30,),
              Row(
                      children: [
                        Expanded(child: Container(),),
                        
                        RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                      text:"Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                      text:"Create Account",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap =()=>Get.to(()=>SignUp()),
                      ),
                      ],
                    ),
                  
                    ),
                    Expanded(child: Container(),),
                  
                      ],
                    ),
                    
                ],
            ),
          ),
        ],
      ),
       
        ],
      ), 
    );
  }

}

