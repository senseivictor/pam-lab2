import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.pro = false,
  });

  final String title;
  final String imagePath;
  final bool pro;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 146,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover)),
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x22000000), Color(0xdd000000)],
                    ),
                  ),
                ),
              ),
              if (pro)
                const Positioned(right: 7, top: 8, child: _ProPill()),
              Positioned(
                left: 12,
                right: 8,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 7),
                    const Text('210 kcal  -  120 min', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _ProPill extends StatelessWidget {
  const _ProPill();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: const Text('Pro', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w700, fontSize: 10)),
      );
}
