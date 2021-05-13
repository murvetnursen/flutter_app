// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_app/nav.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLC Trip Data',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Nav(),
    );
  }
}
