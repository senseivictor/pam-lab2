import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onStart,
  });

  final String title;
  final String imagePath;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 277,
        child: InkWell(
          onTap: onStart,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: 0,
                  width: 330,
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(19, 20, 15, 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 10),
                      const Text('5 week  -  4x/week', style: TextStyle(color: Color(0xffe8eaf0), fontSize: 12)),
                      const Spacer(),
                      SizedBox(
                        height: 31,
                        child: FilledButton(
                          onPressed: onStart,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          child: const Text('Start Now', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
