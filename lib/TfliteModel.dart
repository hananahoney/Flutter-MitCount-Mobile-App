import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_image_classification/main_drawer.dart';
import 'auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

class Patient {
  final int id;
  final String name;
  final String image1;
  final String image2;

  Patient({
    required this.id,
    required this.name,
    required this.image1,
    required this.image2,
  });
}

class TfliteModel extends StatefulWidget {
  TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {

  final List<Patient> patients = [
    Patient(
      id: 3,
      name: 'ali',
      image1: 'assets/image1.png',
      image2: 'assets/resultant image1.jpg',
    ),
    Patient(
      id: 5,
      name: 'hina',
      image1: 'assets/image2.jpg',
      image2: 'assets/resultant image2.jpg',
    ),
    Patient(
      id: 7,
      name: 'honey',
      image1: 'assets/image3.jpg',
      image2: 'assets/resultant image3.jpg',
    ),
    Patient(
      id: 8,
      name: 'zain',
      image1: 'assets/image4.jpg',
      image2: 'assets/resultant image4.jpg',
    ),
    Patient(
      id: 10,
      name: 'yasmin',
      image1: 'assets/image5.jpg',
      image2: 'assets/resultant image5.jpg',
    ),
    Patient(
      id: 12,
      name: 'yasin',
      image1: 'assets/image6.jpg',
      image2: 'assets/resultant image6.jpg',
    ),
    Patient(
      id: 13,
      name: 'anas',
      image1: 'assets/image7.jpg',
      image2: 'assets/resultant image7.jpg',
    ),
    Patient(
      id: 18,
      name: 'sadia',
      image1: 'assets/image8.jpg',
      image2: 'assets/resultant image8.jpg',
    ),
    Patient(
      id: 20,
      name: 'sam',
      image1: 'assets/image9.jpg',
      image2: 'assets/resultant image9.jpg',
    ),
    Patient(
      id: 22,
      name: 'hadia',
      image1: 'assets/image10.jpg',
      image2: 'assets/resultant image10.jpg',
    ),
    Patient(
      id: 25,
      name: 'maham',
      image1: 'assets/image23.jpg',
      image2: 'assets/resultant image23.jpg',
    ),
    // Add more patients here as needed
  ];
  
  late File _image;
  late List _results;
  late String _uid = "";
  dynamic data;
  bool imageSelect=false;
  bool loading = false;
  String message = "";

  @override
  void initState()
  {
    super.initState();
    setState(() {
      loading = true;
    });
    loadModel();
    getData();
    
  }
  Future loadModel()
  async {
    Tflite.close();
    String res;
    res=(await Tflite.loadModel(model: "assets/breast_cancer_tf.tflite",labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }
  Future<dynamic> getData()async{
    
    User? user = FirebaseAuth.instance.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      data = userDoc.data();
      loading = false;
    });
  }

  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
    });
  }

  

  Future<void> FlaskUpload() async {
    final request = http.MultipartRequest("POST",Uri.parse("https://8049-2404-3100-1808-74e0-2407-a7c4-ddd0-8235.ap.ngrok.io/upload"));
    final headers = {"content-type": "multipart/form-data"};

    request.files.add(
      http.MultipartFile('image', _image.readAsBytes().asStream(),_image.lengthSync(),
      filename: _image.path.split("/").last)
    );

    //File image = await http.get(Uri.parse("https://9a26-103-163-238-186.in.ngrok.io/upload")) as File;
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    print(resJson["message"]);
    setState(() {
      message = resJson['message'];
    });
    
    
    // File image = await responseToImageFile(res);
  }

  // Future<void> FlaskFetch() async {
  //   final response = await http.get(Uri.parse("https://cf93-103-163-238-186.in.ngrok.io/upload"));

  //   final decoded = json.decode(response.body) as Map<String,dynamic>;
//}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients Record'),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: main_drawer(data: data,),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.grey,
          padding: EdgeInsets.only(top:16.0,bottom: 16.0,left: 10,right: 10),
          
          child: Table(
            border: TableBorder.all(),
            
            // defaultColumnWidth: ixedColumnHeight(120.0),
            children: [
              TableRow(
                children: [
                  TableCell(child: Container(
                    height: 20,
                    child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Container(
                    height: 20,
                    child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Container(
                    height: 20,
                    child: Text('Image 1', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  TableCell(child: Container(
                    height: 20,
                    child: Text('Image 2', style: TextStyle(fontWeight: FontWeight.bold)),
                  )),
                  // TableCell(child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
                  // TableCell(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  // TableCell(child: Text('Image 1', style: TextStyle(fontWeight: FontWeight.bold))),
                  // TableCell(child: Text('Image 2', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              for (final patient in patients)
                TableRow(
                  children: [
                    TableCell(child: Container(
                    height: 60,
                    child: Text(' '+patient.id.toString()),
                  )),
                    // TableCell(child: Text(' '+patient.id.toString())),
                    TableCell(child: Container(
                    height: 60,
                    child: Text(' '+patient.name)),
                    ),
                    // TableCell(child: Text(' '+patient.name)),
                    TableCell(child: Container(
                    height: 60,
                    child: Image.asset(patient.image1, width: 50, height: 50)),
                    ),
                    // TableCell(child: Image.asset(patient.image1, width: 50, height: 50)),
                    TableCell(child: Container(
                    height: 60,
                    child: Image.asset(patient.image2, width: 50, height: 50)),
                    ),
                    // TableCell(child: Image.asset(patient.image2, width: 50, height: 50)),
                  ],
                ),
            ],
          ),
        ),
        ),
      
    );
    // return (loading)?Scaffold(body:Center(child:CircularProgressIndicator(color: Colors.pinkAccent,)),):Scaffold(
    //   appBar: AppBar(
    //     title: const Text("MitCount"),
    //     backgroundColor: Colors.pinkAccent,
    //   ),
    //   drawer: main_drawer(data: data,),
    //   body: ListView(
    //     children: [
    //       (imageSelect)?Container(
    //     margin: const EdgeInsets.all(10),
    //     child: Image.file(_image),
    //   ):Container(
    //     margin: const EdgeInsets.all(10),
    //         child: const Opacity(
    //           opacity: 0.8,
    //           child: Center(
    //             child: Text("No image selected"),
    //           ),
    //         ),
    //   ),
    //       SingleChildScrollView(
    //         child: Column(
    //           children: [

    //             Text(message),


    //         // Row(
    //         //     children: [Container(
    //         //       margin: EdgeInsets.all(10),
    //         //       child: (imageSelect)?Text(
    //         //           _results[0]['confidence']>_results[1]['confidence']?
    //         //               "${_results[0]['label']}"=="1"?
    //         //                   "cancerous with confidence level \n ${_results[0]['confidence']}"
    //         //                   :"not cancerous with confidence level \n ${_results[0]['confidence']}"
    //         //         :"${_results[1]['label']}"=="1"?
    //         //           "cancerous with confidence level \n ${_results[1]['confidence']}"
    //         //               :"not cancerous with confidence level \n ${_results[1]['confidence']}",
                    
    //         //         style: const TextStyle(color: Colors.red,
    //         //         fontSize: 20),
    //         //       ):Text(''),
    //         //     ),
    //         //     ],
    //         //   )

    //             ]
    //           // (imageSelect)?_results.map((result) {
    //           //   return Card(
    //           //     child: Container(
    //           //       margin: EdgeInsets.all(10),
    //           //       child: Text(
    //           //         "${result['label']} = ${result['confidence'].toStringAsFixed(2)}",
    //           //         style: const TextStyle(color: Colors.red,
    //           //         fontSize: 20),
    //           //       ),
    //           //     ),
    //           //   );
    //           // }).toList():[],

    //         ),
    //       ),
    //       // Container(
    //       //   margin: EdgeInsets.only(left: 100,right: 100,bottom: 30,top: 20),
    //       //   child : ElevatedButton(
    //       //       child :Text('Upload Image',style: TextStyle(color: Colors.white),) ,
    //       //       style: ElevatedButton.styleFrom(
    //       //         backgroundColor: Colors.pinkAccent,
    //       //       shape: RoundedRectangleBorder(
    //       //         borderRadius: BorderRadius.circular(100),
                
    //       //       ),
    //       //     ),
    //       //       // color: Colors.pinkAccent,
    //       //       // shape: RoundedRectangleBorder(
    //       //       //     borderRadius: BorderRadius.circular(100)),
    //       //       onPressed:pickImage
    //       //   ),
    //       // ),

    //       // Container(
    //       //   margin: EdgeInsets.only(left: 100,right: 100,bottom: 50,top: 0),
    //       //   child : ElevatedButton(
    //       //       child :Text('Diagnose',style: TextStyle(color: Colors.white),) ,
    //       //       style: ElevatedButton.styleFrom(
    //       //         backgroundColor: Colors.pinkAccent,
    //       //       shape: RoundedRectangleBorder(
    //       //         borderRadius: BorderRadius.circular(100),
                
    //       //       ),
    //       //     ),
    //       //       // color: Colors.pinkAccent,
    //       //       // shape: RoundedRectangleBorder(
    //       //       //     borderRadius: BorderRadius.circular(100)),
    //       //       onPressed:(){
    //       //         FlaskUpload();
    //       //         //FlaskFetch();
    //       //       },
    //       //   ),
    //       // ),

    //     ],
    //   ),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: pickImage,
    //   //   tooltip: "Pick Image",
    //   //   child: const Icon(Icons.image),
    //   // ),
    // );
  }
  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }
}










