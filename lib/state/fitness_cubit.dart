import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fitness_repository.dart';
import '../models/fitness_program.dart';
import 'fitness_state.dart';

class FitnessCubit extends Cubit<FitnessState> {
  FitnessCubit(this._repository) : super(const FitnessState());

  final FitnessRepository _repository;

  Future<void> loadPrograms() async {
    emit(state.copyWith(status: FitnessStatus.loading));
    try {
      final programs = await _repository.loadPrograms();
      final plans = await _repository.loadFeaturedPlans();
      emit(
        state.copyWith(
          status: FitnessStatus.success,
          programs: programs,
          featuredPlans: plans,
          clearError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FitnessStatus.failure,
          errorMessage: 'Nu am putut încărca programele: $error',
        ),
      );
    }
  }

  void searchChanged(String value) => emit(state.copyWith(query: value));
  void categoryChanged(String value) => emit(state.copyWith(category: value));
  void toggleSort() =>
      emit(state.copyWith(sortAscending: !state.sortAscending));

  void toggleFavorite(FitnessProgram program) {
    final favorites = Set<String>.from(state.favorites);
    if (!favorites.add(program.id)) favorites.remove(program.id);
    emit(state.copyWith(favorites: favorites));
  }
}
