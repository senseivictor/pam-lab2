import 'package:flutter/material.dart';
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
  String selectedType = 'All Type';
  bool alertsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 14, 0, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingHeader(
                alertsOn: alertsOn,
                onNotificationsTap: () => setState(() => alertsOn = !alertsOn),
              ),
              const SizedBox(height: 26),
              const ChallengeCard(),
              const SizedBox(height: 25),
              SectionHeader(title: 'Featured Plan', onSeeAll: _showPlans),
              const SizedBox(height: 15),
              _FeaturedPlans(onOpenGym: _openGym),
              const SizedBox(height: 25),
              SectionHeader(title: 'Workout Programs', onSeeAll: _showPrograms),
              const SizedBox(height: 14),
              WorkoutTypeFilter(
                selectedType: selectedType,
                onChanged: (type) => setState(() => selectedType = type),
              ),
              const SizedBox(height: 15),
              const _WorkoutProgramList(),
            ],
          ),
        ),
      ),
    );
  }

  void _openGym() => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const GymDetailScreen()),
      );

  void _showPlans() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All featured plans')),
      );

  void _showPrograms() => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All workout programs')),
      );
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
        padding: const EdgeInsets.only(right: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Friday, 20 May', style: TextStyle(color: AppColors.muted, fontSize: 13)),
                SizedBox(height: 6),
                Text('Good Morning', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
              ],
            ),
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
                child: const Icon(Icons.notifications_none_rounded, color: AppColors.ink),
              ),
            ),
          ],
        ),
      );
}

class _FeaturedPlans extends StatelessWidget {
  const _FeaturedPlans({required this.onOpenGym});

  final VoidCallback onOpenGym;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 135,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            PlanCard(
              title: 'Massive Upper Body',
              imagePath: 'assets/images/featured.jpg',
              onStart: onOpenGym,
            ),
            const SizedBox(width: 14),
            PlanCard(
              title: 'Massive Abs',
              imagePath: 'assets/images/featured.jpg',
              onStart: onOpenGym,
            ),
          ],
        ),
      );
}

class WorkoutTypeFilter extends StatelessWidget {
  const WorkoutTypeFilter({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final String selectedType;
  final ValueChanged<String> onChanged;
  static const _types = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 31,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _types
              .map(
                (type) => Padding(
                  padding: const EdgeInsets.only(right: 9),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: selectedType == type,
                    onSelected: (_) => onChanged(type),
                    selectedColor: AppColors.green,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: selectedType == type
                          ? AppColors.green
                          : const Color(0xffdce1e9),
                    ),
                    labelStyle: TextStyle(
                      color: selectedType == type ? Colors.white : AppColors.muted,
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
      );
}

class _WorkoutProgramList extends StatelessWidget {
  const _WorkoutProgramList();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 172,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            ProgramCard(
              title: 'Yoga',
              imagePath: 'assets/images/yoga.jpg',
            ),
            SizedBox(width: 14),
            ProgramCard(
              title: 'Arm\nStrengthening',
              imagePath: 'assets/images/arm_strength.jpg',
              pro: true,
            ),
          ],
        ),
      );
}
