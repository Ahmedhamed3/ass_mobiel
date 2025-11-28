import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';

import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAsfT5xivM-e4LwN-1ZhT6bK-efVnl7kss",
        authDomain: "studentcoursesapp-10ab0.firebaseapp.com",
        projectId: "studentcoursesapp-10ab0",
        storageBucket: "studentcoursesapp-10ab0.firebasestorage.app",
        messagingSenderId: "784569029300",
        appId: "1:784569029300:web:50e45030bc7ae804a67de1",
        measurementId: "G-N8C9S7EC1V",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Courses App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
