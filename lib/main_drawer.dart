import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tflite_image_classification/TfliteModel.dart';
import 'package:tflite_image_classification/profile.dart';

import 'auth_controller.dart';

class main_drawer extends StatefulWidget {
  dynamic data;
  main_drawer({Key? key,required this.data}) : super(key: key);

  @override
  State<main_drawer> createState() => _main_drawerState();
}

class _main_drawerState extends State<main_drawer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return (loading)?Scaffold(body:Center(child:CircularProgressIndicator(color: Colors.pinkAccent,)),):Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Drawer(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      color: Colors.pinkAccent,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // image: DecorationImage(
                                //   image: NetworkImage(widget.data['url']),
                                //   fit: BoxFit.fill,
                                //   ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              widget.data["fName"]+" "+widget.data["lName"],
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height:10),
                            Text(
                              widget.data["email"],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height:20),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile(data: widget.data)),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.file_copy),
                      title: Text(
                        "Patients",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TfliteModel()),
                        );
                      },
                    ),
                ListTile(
                      leading: Icon(Icons.arrow_back),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        AuthController.instance.logot();
                      },
                    ),
                
                  ],
                ),
              ),
            );
  }
}