import 'package:flutter/material.dart';
import 'package:logoipsum/ReportList/reportlist.dart';
import 'package:logoipsum/ReportSelectionScreen/select_report_type.dart';
import 'package:logoipsum/SplashScreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Logo Ipsum',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const SelectReport(),
          '/splash': (context) => const SplashScreen(),
        });
  }
}
