import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GymDetailScreen extends StatefulWidget {
  const GymDetailScreen({super.key});

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  bool reserved = false;
  final Set<String> amenities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _GymHero(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 23, 22, 106),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _GymSummary(),
                    const SizedBox(height: 16),
                    const Text('Amenities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: ['Showers', 'Lockers', 'Parking', 'Sauna']
                          .map(_amenityTile)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ReservationBar(
        reserved: reserved,
        onReserve: () => setState(() => reserved = !reserved),
      ),
    );
  }

  Widget _amenityTile(String label) {
    final selected = amenities.contains(label);
    return InkWell(
      onTap: () => setState(
        () => selected ? amenities.remove(label) : amenities.add(label),
      ),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 145,
        height: 49,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffe8faef) : const Color(0xfff7f8fa),
          border: Border.all(
            color: selected ? AppColors.green : const Color(0xffdfe3e9),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.checkroom_outlined,
              color: selected ? AppColors.green : AppColors.muted,
              size: 19,
            ),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}

class _GymHero extends StatelessWidget {
  const _GymHero();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 328,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/hero.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 14,
              left: 18,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: .65),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 19,
                  color: Colors.white,
                ),
              ),
            ),
            const Positioned(
              top: 23,
              right: 23,
              child: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
      );
}

class _GymSummary extends StatelessWidget {
  const _GymSummary();

  @override
  Widget build(BuildContext context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: Color(0xffffb33e), size: 19),
              SizedBox(width: 5),
              Text('4.5 ', style: TextStyle(fontWeight: FontWeight.w700)),
              Text('(1,232 reviews)', style: TextStyle(color: AppColors.muted)),
            ],
          ),
          SizedBox(height: 13),
          Text('Mid City Gym Training', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
          SizedBox(height: 11),
          Text('California, New York', style: TextStyle(color: AppColors.muted)),
          Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros laoreet quam sollicitudin. Duis non eu hendrerit amet tellus...',
            style: TextStyle(color: AppColors.muted, height: 1.45),
          ),
        ],
      );
}

class ReservationBar extends StatelessWidget {
  const ReservationBar({
    super.key,
    required this.reserved,
    required this.onReserve,
  });

  final bool reserved;
  final VoidCallback onReserve;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 13,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total', style: TextStyle(color: AppColors.muted, fontSize: 13)),
                    SizedBox(height: 4),
                    Text(r'$69.00', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              SizedBox(
                height: 48,
                width: 145,
                child: FilledButton(
                  onPressed: onReserve,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  ),
                  child: Text(
                    reserved ? 'Reserved' : 'Reserve',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
