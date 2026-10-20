import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 22),
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
      height: 78,
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Challenge", style: TextStyle(color: Color(0xffaeb4c1), fontSize: 13)),
                SizedBox(height: 5),
                Text('Running', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17)),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            width: 48,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircularProgressIndicator(value: .75, strokeWidth: 4, color: AppColors.green, backgroundColor: Color(0xff3f444e)),
                Text('15/20', style: TextStyle(color: Colors.white, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
