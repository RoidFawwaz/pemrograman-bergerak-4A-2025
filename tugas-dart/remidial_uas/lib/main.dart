import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDxMZzEXAMPLEKEY",
        authDomain: "uas-api-001.firebaseapp.com",
        databaseURL: "https://uas-api-001-default-rtdb.firebaseio.com/",
        projectId: "uas-api-001",
        storageBucket: "uas-api-001.appspot.com",
        messagingSenderId: "857941234567",
        appId: "1:857941234567:web:d7d01aa05abcde",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

// nama:mohammad roid fawwaz el shaimy
// nim:230441100183
// kelas:pember-a
// asprak:mas rosid
