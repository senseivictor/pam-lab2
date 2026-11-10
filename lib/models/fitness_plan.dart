class FitnessPlan {
  const FitnessPlan({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
  });

  final String id;
  final String title;
  final String duration;
  final String frequency;

  factory FitnessPlan.fromJson(Map<String, dynamic> json) => FitnessPlan(
    id: json['id'] as String,
    title: json['title'] as String,
    duration: json['duration'] as String? ?? '',
    frequency: json['frequency'] as String? ?? '',
  );
}
