import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/fitness_repository.dart';
import 'screens/home_screen.dart';
import 'state/fitness_cubit.dart';
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
      home: RepositoryProvider(
        create: (_) => FitnessRepository(),
        child: BlocProvider(
          create: (context) => FitnessCubit(context.read<FitnessRepository>()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
