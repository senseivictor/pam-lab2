import '../models/fitness_program.dart';
import '../models/fitness_plan.dart';

enum FitnessStatus { initial, loading, success, failure }

class FitnessState {
  const FitnessState({
    this.status = FitnessStatus.initial,
    this.programs = const [],
    this.featuredPlans = const [],
    this.query = '',
    this.category = 'All Type',
    this.favorites = const {},
    this.sortAscending = true,
    this.errorMessage,
  });

  final FitnessStatus status;
  final List<FitnessProgram> programs;
  final List<FitnessPlan> featuredPlans;
  final String query;
  final String category;
  final Set<String> favorites;
  final bool sortAscending;
  final String? errorMessage;

  List<FitnessProgram> get visiblePrograms {
    final results = programs.where((program) {
      final matchesQuery = program.title.toLowerCase().contains(
        query.toLowerCase(),
      );
      final matchesCategory =
          category == 'All Type' || program.category == category;
      return matchesQuery && matchesCategory;
    }).toList();
    results.sort(
      (a, b) => sortAscending
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title),
    );
    return results;
  }

  FitnessState copyWith({
    FitnessStatus? status,
    List<FitnessProgram>? programs,
    List<FitnessPlan>? featuredPlans,
    String? query,
    String? category,
    Set<String>? favorites,
    bool? sortAscending,
    String? errorMessage,
    bool clearError = false,
  }) => FitnessState(
    status: status ?? this.status,
    programs: programs ?? this.programs,
    featuredPlans: featuredPlans ?? this.featuredPlans,
    query: query ?? this.query,
    category: category ?? this.category,
    favorites: favorites ?? this.favorites,
    sortAscending: sortAscending ?? this.sortAscending,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
