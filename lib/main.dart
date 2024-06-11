import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/screens/home_screen.dart';

void main() {
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
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 25,
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
          titleMedium:TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
      ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle:
          TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color:Colors.black
          ),

        ),
        ),
      home:const HomeScreen(),
    );
  }
}