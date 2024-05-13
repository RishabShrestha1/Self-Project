import 'package:flutter/material.dart';
import 'package:weatherapp_2024/presentation/helpscreen.dart';
import 'package:weatherapp_2024/presentation/homepagescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HelpScreen(),
        routes: <String, WidgetBuilder>{
          '/help': (BuildContext context) => const HelpScreen(),
          'home': (BuildContext context) => const HomePage(),
        });
  }
}
