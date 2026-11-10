class FitnessProgram {
  const FitnessProgram({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;

  factory FitnessProgram.fromJson(Map<String, dynamic> json) => FitnessProgram(
    id: json['id'] as String,
    title: json['title'] as String,
    calories: json['calories'] as int,
    durationMinutes: json['durationMinutes'] as int,
    isPro: json['isPro'] as bool? ?? false,
    imageUrl: json['imageUrl'] as String? ?? '',
  );

  String get category {
    final value = title.toLowerCase();
    if (value.contains('yoga')) return 'Yoga';
    if (value.contains('cardio') || value.contains('running')) return 'Cardio';
    if (value.contains('boxing')) return 'Boxing';
    if (value.contains('pilates')) return 'Pilates';
    return 'Strength';
  }
}
