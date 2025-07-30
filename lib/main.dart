import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './services/firebase_services.dart';
import './providers/forest_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ForestProvider(FirebaseService(), )..loadUserGarden(),
      child: const GrowYourForestApp(),
    ),
  );
}

class GrowYourForestApp extends StatelessWidget {
  const GrowYourForestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grow Your Forest',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      home:  HomeScreen(),
    );
  }
}
