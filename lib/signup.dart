import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'auth_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool _obscureText = true;

 var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var url = "https://firebasestorage.googleapis.com/v0/b/mitcount-dda09.appspot.com/o/profiles%2FprofileM.png?alt=media&token=b35473a1-c010-4bb8-80ca-1ad63f45b215";
    List images = [
      "assets/google.png",
      "assets/facebook.png",
      "assets/twitterr.png"
    ];
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
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            width: w,
            height: h*0.25,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'),
              alignment: Alignment.topLeft,
              fit: BoxFit.scaleDown,
              )
            ),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: h*0.1,),
                Text(
                  
                  "MitCount",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                
                ),
                ),
                Text(
                  
                  "Let's create an account",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey
                
                ),
                ),
                SizedBox(height: h*0.08,),
                
                
              ],
            ),
          ),
          Container(
            width: w,
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                  
                //   children: [
                //   Expanded(child: Container(),),
                        
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.circle,
                //       boxShadow: [
                //         BoxShadow(
                //           blurRadius: 10,
                //           color: Colors.grey.withOpacity(0.5), 
                //           spreadRadius: 5
                //           ),
                //           ],
                //     ),
                //     margin: EdgeInsets.only(right: 30,),
                //     child:CircleAvatar(
                //   radius: 50,
                //   backgroundColor: Color.fromARGB(255, 255, 127, 170),
                //   backgroundImage: AssetImage('assets/profile.png'),
                // ),
                //   )
                //     //Expanded(child: Container(),),
                  
                //       ],
                //     ),
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
                    controller: firstNameController,
                    autofocus: true,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return ("Please Enter Your First Name");
                      }
                      return null;
                    },
                    onSaved: (value){
                      firstNameController.text = value!;
                    },
                    
                  decoration: InputDecoration(
                    hintText: "First Name",
                    prefixIcon: Icon(Icons.text_format_outlined,color: Colors.pinkAccent),
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
                SizedBox(height:20),
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
                    controller: lastNameController,
                    autofocus: true,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return ("Please Enter Your Last Name");
                      }
                      return null;
                    },
                    onSaved: (value){
                      lastNameController.text = value!;
                    },
                  
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    prefixIcon: Icon(Icons.text_format_outlined,color: Colors.pinkAccent),
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
                    controller: emailController,
                    autofocus: true,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return ("Please Enter Your Email");
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return ("Please Entera valid email");
                      }
                      return null;
                    },
                    onSaved: (value){
                      passwordController.text = value!;
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
                      if(value == null || value.isEmpty){
                        return ("Please Enter your password");
                      }
                      if(!regex.hasMatch(value)){
                        return ("Please Enter valid password of Min. 6 characters");
                      }
                    },
                    onSaved: (value){
                      passwordController.text = value!;
                    },
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.vpn_key,color: Colors.pinkAccent),
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
              
                SizedBox(height:10,),
                Container(
                  width: w,
                  height: 50,
                  margin: EdgeInsets.only(left: 70,right: 70,bottom: 0,top: 0),
                  child : ElevatedButton(
                      child :Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),) ,
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                       shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    
                    ),
                  ),
                      // color: Colors.pinkAccent,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(100)),
                      onPressed:() {
                        
                        AuthController.instance.register(emailController.text.trim(), passwordController.text.trim(),firstNameController.text.toString(),lastNameController.text.toString(),url);
                        
                      },
                  ),
          ),
          SizedBox(height: 20,),
          Row(
                      children: [
                        Expanded(child: Container(),),
                        
                        RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                      text:"Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                      text:"Sign In",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.pinkAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap =()=>Get.back(),
                      ),
                      ],
                    ),
                  
                    ),
                    Expanded(child: Container(),),
                  
                      ],
                    ),
                
              // Row(
              //         children: [
              //           Expanded(child: Container(),),
                        
              //           RichText(
              //         textAlign: TextAlign.center,
              //         text: TextSpan(
              //         text:"Signup using one of the following methods",
              //         style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 13,
              //         ),
              //       ),
                  
              //       ),
              //       Expanded(child: Container(),),
                  
              //         ],
              //       ),
              SizedBox(height: 20,),

                    Align(
                      alignment: Alignment.center,
                      child:Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        GestureDetector(
                         onTap:(){
                            AuthController.instance.registerwithGoogle();
                            print("akjfasfhd");
                          },
                        child:CircleAvatar(
                          
                          backgroundColor: Colors.white,
                        radius: 25,
                        backgroundImage: AssetImage(images[0]),
                      ),
                        ),
                        SizedBox(width: 10,height: 20,),
                        GestureDetector(
                         
                        child:CircleAvatar(
                          backgroundColor: Colors.white,
                        radius: 25,
                        backgroundImage: AssetImage(images[1]),
                      ),
                        ),
                        SizedBox(width: 10,height: 40,),
                        GestureDetector(
                         
                        child:CircleAvatar(
                          backgroundColor: Colors.white,
                        radius: 25,
                        backgroundImage: AssetImage(images[2]),
                      ),
                        ),
                        SizedBox(width: 10,height: 20,),
                        
                      
                      ]
                      
                    ),
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