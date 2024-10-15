import 'package:flutter/material.dart';
import 'package:radio_app/home/home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        scaffoldBackgroundColor: bgcolor,
      ),
      home: HomePage(),
    );
  }
}

const bgcolor = Color.fromARGB(255, 10, 19, 30);
