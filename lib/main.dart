import 'package:flutter/material.dart';
import 'package:frivia/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizie',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 199, 134)),
        scaffoldBackgroundColor: const Color.fromRGBO(
          31,
          31,
          31,
          1.9,
        ),
        useMaterial3: true,
        //fontFamily: 'ArchitectsDaughter',
        textTheme: GoogleFonts.ubuntuTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}