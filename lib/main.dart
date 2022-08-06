import 'package:flutter/material.dart';
import 'homepage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        color: Colors.pink[900],
        ),
       
        primaryColor: const Color.fromRGBO(161, 43, 110, 1),
      ),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
