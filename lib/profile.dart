import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_image_classification/TfliteModel.dart';

import 'main_drawer.dart';

class Profile extends StatefulWidget {
  dynamic data;
  Profile({Key? key,required this.data}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late File _image;
  bool imageSelect= false;
  late String? _lName="";
  late String? _fName='';
  late String? _email='';
  UploadTask? uploadTask;
  String profileUrl = "";
  bool loading = false;
  
  var firstnameController;
  var lastnameController;
  var emailController;
  //var emailController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fName=widget.data['fName'];
    _lName=widget.data['lName'];
    _email=widget.data['email'];
    profileUrl = widget.data['url'];

    emailController = TextEditingController(text: widget.data['email']);
    lastnameController = TextEditingController(text: widget.data['lName']);
    firstnameController = TextEditingController(text: widget.data['fName']);
    
  }
 

  @override
  Widget build(BuildContext context) {
    
    return (loading)?Scaffold(body:Center(child:CircularProgressIndicator(color: Colors.pinkAccent,)),):Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: main_drawer(data: widget.data,),
      body: SingleChildScrollView(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70,),
                  // (!imageSelect)?Container(
                  //   child: GestureDetector(
                  //   onTap: () {
                  //     pickImage();
                  //   }, // Image tapped
                  //   child: Container(
                  //     //child: Image.file(_image),
                  //             width: 100,
                  //             height: 100,
                            
                  //             margin: EdgeInsets.only(top: 30),
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,

                  //               image: DecorationImage(
                  //                 image: NetworkImage(widget.data["url"]),
                  //                 fit: BoxFit.fill,
                                  
                  //                 ),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.grey.withOpacity(0.5),
                  //                     spreadRadius: 5,
                  //                     blurRadius: 7,
                  //                     offset: Offset(0, 3), // changes position of shadow
                  //                   ),
                  //                 ],
                  //             ),
                  //           ),
                
                  //   ),
                  // ):Container(
                  //   child: GestureDetector(
                  //   onTap: () {
                  //     pickImage();
                  //   }, // Image tapped
                  //   child: Container(
                  //     //child: Image.file(_image),
                  //             width: 100,
                  //             height: 100,
                            
                  //             margin: EdgeInsets.only(top: 30),
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,

                  //               image: DecorationImage(
                  //                 image: FileImage(File(_image.path)) as ImageProvider,
                  //                 fit: BoxFit.fill,
                                  
                  //                 ),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.grey.withOpacity(0.5),
                  //                     spreadRadius: 5,
                  //                     blurRadius: 7,
                  //                     offset: Offset(0, 3), // changes position of shadow
                  //                   ),
                  //                 ],
                  //             ),
                  //           ),
                
                  //   ),
                  // ),
                 ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:30.0,left: 30.0,right: 30.0),
              child: TextFormField(
                controller: firstnameController,
                //  initialValue: _fName,
                  
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: "First Name",
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
            Container(
              margin: EdgeInsets.only(top:30.0,left: 30.0,right: 30.0),
              child: TextFormField(
                controller: lastnameController,
                //  initialValue: _lName,
                  
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: "Last Name",
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
            Container(
              
              margin: EdgeInsets.only(top:30.0,left: 30.0,right: 30.0),
              child: TextFormField(
                controller: emailController,
                //  initialValue: _email,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: "Email",
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
            SizedBox(height: 30,),
            Container(
            margin: EdgeInsets.only(left: 80,right: 80,bottom: 30,top: 20),
            child : ElevatedButton(
                child :Text('          Update          ',style: TextStyle(color: Colors.white),) ,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    
                  )
                ),
                // color: Colors.pinkAccent,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(100)),
                onPressed:(){
                      
                  setState(() {
                    loading = true;
                  });
                      UploadImage();
                     
                },
            ),
          ),
          ],
        ),
      ),
    );
  }
  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    setState(() {
      _image=image;
      imageSelect=true;
    });
  }

  
    void UploadImage()
    async{
      if(imageSelect)
      {
        final image = _image;
        late String _uid;
        User? user = FirebaseAuth.instance.currentUser;
        _uid = user!.uid;
        final path = 'profiles/'+_uid;
        Reference ref = FirebaseStorage.instance.ref().child(path);
        await  ref.putFile(File(image.path));
        ref.getDownloadURL().then((value) {
          updateData(firstnameController.text.trim(), lastnameController.text.trim(), emailController.text.trim(), value);
          print(value);
        });
      }
      else{
        updateData(firstnameController.text.trim(), lastnameController.text.trim(), emailController.text.trim(), widget.data['url']);
      }
      

    }

    void updateData(String fName, String lName, String email, String url)async{
      
      User? user = FirebaseAuth.instance.currentUser;
      if(imageSelect)
      {
        
      }
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
        'email':email,
        'fName':fName,
        'lName':lName,
        'url':url,
      });
      refreshUser();
      

    }

    Future<dynamic> refreshUser()async{
      String _uid="";
      User? user = FirebaseAuth.instance.currentUser;
      _uid = user!.uid;
      await user.reload();
  }

    Future<dynamic> getData()async{
      String _uid="";
      User? user = FirebaseAuth.instance.currentUser;
      _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      setState(() {
        widget.data = userDoc.data();
      });
  }

  
 
}