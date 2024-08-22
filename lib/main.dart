import 'package:flutter/material.dart';
import 'package:lab/constants/colors.dart';
import 'package:lab/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
            surfaceTintColor: backgroundColor),
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
