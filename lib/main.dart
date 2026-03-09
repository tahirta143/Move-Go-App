import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'custommer_app/screens/splash_screens/onboarding_1/onboarding_1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MoveGoApp());
}

class MoveGoApp extends StatelessWidget {
  const MoveGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Move-GO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}