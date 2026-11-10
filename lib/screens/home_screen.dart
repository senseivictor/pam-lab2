import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/fitness_program.dart';
import '../state/fitness_cubit.dart';
import '../state/fitness_state.dart';
import '../theme/app_colors.dart';
import '../widgets/challenge_card.dart';
import '../widgets/plan_card.dart';
import '../widgets/program_card.dart';
import '../widgets/section_header.dart';
import 'gym_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _alertsOn = false;

  @override
  void initState() {
    super.initState();
    context.read<FitnessCubit>().loadPrograms();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 14, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GreetingHeader(
              alertsOn: _alertsOn,
              onNotificationsTap: () => setState(() => _alertsOn = !_alertsOn),
            ),
            const SizedBox(height: 26),
            const ChallengeCard(),
            const SizedBox(height: 25),
            SectionHeader(title: 'Featured Plan', onSeeAll: _showPlans),
            const SizedBox(height: 15),
            BlocBuilder<FitnessCubit, FitnessState>(
              builder: (context, state) {
                if (state.status == FitnessStatus.loading ||
                    state.status == FitnessStatus.initial) {
                  return const SizedBox(
                    height: 135,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.status == FitnessStatus.failure) {
                  return SizedBox(
                    height: 135,
                    child: Center(
                      child: Text(state.errorMessage ?? 'Eroare la încărcare'),
                    ),
                  );
                }
                if (state.featuredPlans.isEmpty) {
                  return const SizedBox(
                    height: 135,
                    child: Center(child: Text('Nu există planuri')),
                  );
                }
                return SizedBox(
                  height: 135,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.featuredPlans.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final plan = state.featuredPlans[index];
                      return PlanCard(
                        title: plan.title,
                        duration: plan.duration,
                        frequency: plan.frequency,
                        imagePath: 'assets/images/featured.jpg',
                        onStart: _openGym,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            SectionHeader(title: 'Workout Programs', onSeeAll: _showPrograms),
            const SizedBox(height: 14),
            _WorkoutTypeFilter(
              onChanged: context.read<FitnessCubit>().categoryChanged,
            ),
            const SizedBox(height: 15),
            _WorkoutProgramList(
              onOpen: _openGym,
            ),
          ],
        ),
      ),
    ),
  );

  void _openGym() =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const GymDetailScreen()));

  void _showPlans() =>
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('All featured plans')));

  void _showPrograms() =>
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('All workout programs')));
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader({
    required this.alertsOn,
    required this.onNotificationsTap,
  });

  final bool alertsOn;
  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Friday, 20 May',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            SizedBox(height: 6),
            Text(
              'Good Morning',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              tooltip: 'Notifications',
              onPressed: onNotificationsTap,
              style: IconButton.styleFrom(
                side: const BorderSide(color: Color(0xffe2e5ea)),
                shape: const CircleBorder(),
              ),
              icon: Badge(
                isLabelVisible: alertsOn,
                smallSize: 7,
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.ink,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _WorkoutTypeFilter extends StatelessWidget {
  const _WorkoutTypeFilter({required this.onChanged});
  final ValueChanged<String> onChanged;
  static const _types = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];

  @override
  Widget build(BuildContext context) => BlocBuilder<FitnessCubit, FitnessState>(
    buildWhen: (previous, current) => previous.category != current.category,
    builder: (context, state) => SizedBox(
      height: 31,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _types
            .map(
              (type) => Padding(
                padding: const EdgeInsets.only(right: 9),
                child: ChoiceChip(
                  label: Text(type),
                  selected: state.category == type,
                  onSelected: (_) => onChanged(type),
                  selectedColor: AppColors.green,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: state.category == type
                        ? AppColors.green
                        : const Color(0xffdce1e9),
                  ),
                  labelStyle: TextStyle(
                    color: state.category == type
                        ? Colors.white
                        : AppColors.muted,
                    fontSize: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            )
            .toList(),
      ),
    ),
  );
}

class _WorkoutProgramList extends StatelessWidget {
  const _WorkoutProgramList({required this.onOpen});
  final VoidCallback onOpen;

  String _imageFor(FitnessProgram program) {
    switch (program.id) {
      case 'wp001':
        return 'assets/images/yoga.jpg';
      case 'wp002':
        return 'assets/images/arm-strength.jpg';
      default:
        return 'assets/images/featured.jpg';
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<FitnessCubit, FitnessState>(
    builder: (context, state) {
      if (state.status == FitnessStatus.initial ||
          state.status == FitnessStatus.loading) {
        return const SizedBox(
          height: 172,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (state.status == FitnessStatus.failure) {
        return SizedBox(
          height: 172,
          child: Center(
            child: Text(state.errorMessage ?? 'Eroare la încărcare'),
          ),
        );
      }
      final programs = state.visiblePrograms;
      if (programs.isEmpty) {
        return const SizedBox(
          height: 172,
          child: Center(child: Text('No programs found')),
        );
      }
      return SizedBox(
        height: 172,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: programs.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final program = programs[index];
            return ProgramCard(
              title: program.title,
              imagePath: _imageFor(program),
              pro: program.isPro,
              calories: program.calories,
              durationMinutes: program.durationMinutes,
              isFavorite: state.favorites.contains(program.id),
              onFavorite: () =>
                  context.read<FitnessCubit>().toggleFavorite(program),
              onTap: onOpen,
            );
          },
        ),
      );
    },
  );
}
