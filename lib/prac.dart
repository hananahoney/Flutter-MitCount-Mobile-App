import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'mysql.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var db = Mysql();
  late File _image;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
String generateHash(String password, String eemail) {
  var bytes = utf8.encode(password + eemail); // convert string to bytes
  var digest = sha256.convert(bytes); // generate hash
  return digest.toString(); // return hash as string
}


fetchascii() async{
  try{
  http.Response res = await http.get(Uri.parse("http://localhost:5000/api?query=a"));
  print(res.body.toString());
  }
  catch(e){
    print(e);
  }
}

Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

void flask() async{
  // final request = http.MultipartRequest("POST",Uri.parse("http://127.0.0.1:5000/register"));
  //   final headers = {"content-type": "multipart/form-data"};

  //   request.files.add(
  //     http.MultipartFile('image', _image.readAsBytes().asStream(),_image.lengthSync(),
  //     filename: _image.path.split("/").last)
  //   );

  //   //File image = await http.get(Uri.parse("https://9a26-103-163-238-186.in.ngrok.io/upload")) as File;
  //   request.headers.addAll(headers);
  //   final response = await request.send();
  //   http.Response res = await http.Response.fromStream(response);
  var body = {
    'name': 'John Doe', // Replace with the user's name
    'password': 'password123',
    'email': 'ali@gmail.com' // Replace with the user's password
  };
  // var response = await http.post(
  //     Uri.parse("http://127.0.0.1:5000/register"),
  //     body: body,
  //   );
    try {
    var response = await http.post(
      Uri.parse("http://localhost/register"),
      body: body,
    );

    if (response.statusCode == 200) {
      // Request successful
      print('Credentials sent successfully');
    } else {
      // Request failed
      print('Failed to send credentials');
    }
  } catch (e) {
    // Error occurred
    print('Error: $e');
  }
    print('enterrrrrrrrrrrrrrrrrr');
}

void get_data(){
  try{
    db.getConnection().then((conn) {
    String sql = 'SELECT * FROM user';
    conn.query(sql).then((results) {
      print(results);
    });
    
  });
  }
  catch(e){
    print(e);
  }

  
  // final settings = ConnectionSettings(
  //   host: 'localhost',
  //   port: 3306,
  //   user: 'root',
  //   password: '',
  //   db: 'mbilal',
  // );

  // final conn = await MySqlConnection.connect(settings);
  // print('Enterrrrrrrrrrrrrrrrrrrrrr');

  // final results = await conn.query('SELECT * FROM user');
  // print(results);
  
  // // for (var row in results) {
  // //   print('ID: ${row[0]}, Name: ${row[1]}, Email: ${row[2]}, Password: ${row[3]}');
  // // }

  // await conn.close();
}

void encrypt() {
    String password = '22222222';
    String eemail = 'ali@gmail.com';
    String hash = generateHash(password, eemail);
    print(hash);
}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Practice'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // _incrementCounter;
          // encrypt();
          get_data();
          // pickImage();
          // flask();
          // fetchascii();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
