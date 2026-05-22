class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String unit; // 'reps', 'sec', 'min'

  const Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.unit,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets,
    'reps': reps,
    'unit': unit,
  };
}

class DayProgram {
  final int day;
  final String name;
  final String type; // strength, cardio, hiit, core, rest
  final String title;
  final String emoji;
  final List<Exercise> exercises;

  const DayProgram({
    required this.day,
    required this.name,
    required this.type,
    required this.title,
    required this.emoji,
    required this.exercises,
  });
}

const List<DayProgram> weeklyProgram = [
  DayProgram(
    day: 1,
    name: '週一',
    type: 'strength',
    title: '上肢重訓',
    emoji: '💪',
    exercises: [
      Exercise(name: '伏地挺身', sets: 3, reps: 10, unit: 'reps'),
      Exercise(name: '啞鈴肩推', sets: 3, reps: 10, unit: 'reps'),
      Exercise(name: '三頭撐體', sets: 3, reps: 10, unit: 'reps'),
    ],
  ),
  DayProgram(
    day: 2,
    name: '週二',
    type: 'cardio',
    title: '有氧訓練',
    emoji: '🏃',
    exercises: [
      Exercise(name: '快走／慢跑', sets: 1, reps: 30, unit: 'min'),
    ],
  ),
  DayProgram(
    day: 3,
    name: '週三',
    type: 'strength',
    title: '下肢重訓',
    emoji: '🦵',
    exercises: [
      Exercise(name: '深蹲', sets: 3, reps: 12, unit: 'reps'),
      Exercise(name: '弓步蹲', sets: 3, reps: 10, unit: 'reps'),
      Exercise(name: '臀橋', sets: 3, reps: 15, unit: 'reps'),
    ],
  ),
  DayProgram(
    day: 4,
    name: '週四',
    type: 'core',
    title: '核心＋伸展',
    emoji: '🧘',
    exercises: [
      Exercise(name: '平板支撐', sets: 3, reps: 30, unit: 'sec'),
      Exercise(name: '捲腹', sets: 3, reps: 15, unit: 'reps'),
      Exercise(name: '全身伸展', sets: 1, reps: 20, unit: 'min'),
    ],
  ),
  DayProgram(
    day: 5,
    name: '週五',
    type: 'strength',
    title: '上肢重訓（背）',
    emoji: '🏋️',
    exercises: [
      Exercise(name: '啞鈴划船', sets: 3, reps: 10, unit: 'reps'),
      Exercise(name: '彈力帶下拉', sets: 3, reps: 10, unit: 'reps'),
      Exercise(name: '二頭彎舉', sets: 3, reps: 12, unit: 'reps'),
    ],
  ),
  DayProgram(
    day: 6,
    name: '週六',
    type: 'hiit',
    title: 'HIIT 有氧',
    emoji: '⚡',
    exercises: [
      Exercise(name: '波比跳', sets: 4, reps: 10, unit: 'reps'),
      Exercise(name: '開合跳', sets: 4, reps: 30, unit: 'reps'),
      Exercise(name: '高抬腿', sets: 4, reps: 20, unit: 'reps'),
    ],
  ),
  DayProgram(
    day: 7,
    name: '週日',
    type: 'rest',
    title: '休息恢復',
    emoji: '😴',
    exercises: [],
  ),
];

// Get today's program (1=Mon, 7=Sun)
DayProgram getTodayProgram() {
  final weekday = DateTime.now().weekday; // 1=Mon, 7=Sun
  return weeklyProgram[weekday - 1];
}
