import 'package:book_finder/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        colorScheme: ColorScheme.light(
            primary: Colors.deepPurple, secondary: Colors.deepPurple),
        accentColor: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        fontFamily: 'Lato',
      ),
      home: MyHomePage(),
    );
  }
}
