// ignore_for_file: unused_import

import 'package:projeto_final/pages/auth_or_app_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
      title: 'ConstrueStock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(142, 30, 3, 1)),
        useMaterial3: true,
      ),
    );
  }
}

