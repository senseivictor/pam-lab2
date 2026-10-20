import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_colors.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        fontFamily: 'Arial',
      ),
      home: const HomeScreen(),
    );
  }
}
