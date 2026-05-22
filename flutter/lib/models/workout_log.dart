class WorkoutLog {
  final int? id;
  final String telegramId;
  final DateTime date;
  final int dayOfWeek;
  final String workoutType;
  final List<Map<String, dynamic>> exercisesCompleted;
  final int durationMinutes;
  final String notes;
  final bool completed;
  final String aiFeedback;

  WorkoutLog({
    this.id,
    required this.telegramId,
    required this.date,
    required this.dayOfWeek,
    required this.workoutType,
    required this.exercisesCompleted,
    required this.durationMinutes,
    this.notes = '',
    required this.completed,
    this.aiFeedback = '',
  });

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
    id: json['id'],
    telegramId: json['telegram_id'] ?? '',
    date: DateTime.parse(json['date']),
    dayOfWeek: json['day_of_week'],
    workoutType: json['workout_type'],
    exercisesCompleted:
        List<Map<String, dynamic>>.from(json['exercises_completed'] ?? []),
    durationMinutes: json['duration_minutes'] ?? 0,
    notes: json['notes'] ?? '',
    completed: json['completed'] ?? true,
    aiFeedback: json['ai_feedback'] ?? '',
  );
}
