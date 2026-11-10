import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/fitness_program.dart';
import '../models/fitness_plan.dart';

class FitnessRepository {
  Future<Map<String, dynamic>> _loadHomeData() async {
    final source = await rootBundle.loadString('assets/data/fitness_data.json');
    final json = jsonDecode(source) as Map<String, dynamic>;
    return json['fitnessHomePage'] as Map<String, dynamic>;
  }

  Future<List<FitnessProgram>> loadPrograms() async {
    final home = await _loadHomeData();
    final programs = home['workoutPrograms'] as Map<String, dynamic>;
    return (programs['items'] as List<dynamic>)
        .map((item) => FitnessProgram.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<FitnessPlan>> loadFeaturedPlans() async {
    final home = await _loadHomeData();
    return (home['featuredPlans'] as List<dynamic>)
        .map((item) => FitnessPlan.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
