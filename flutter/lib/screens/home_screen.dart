import 'package:flutter/material.dart';
import '../constants/program.dart';
import 'workout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color _typeColor(String type) {
    switch (type) {
      case 'strength': return const Color(0xFFFF6B6B);
      case 'cardio':   return const Color(0xFF4ECDC4);
      case 'hiit':     return const Color(0xFFFFD93D);
      case 'core':     return const Color(0xFF30D158);
      default:         return const Color(0xFF8E8E93);
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'strength': return '重訓';
      case 'cardio':   return '有氧';
      case 'hiit':     return 'HIIT';
      case 'core':     return '核心';
      default:         return '休息';
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = getTodayProgram();
    final now = DateTime.now();
    final weekdays = ['', '週一', '週二', '週三', '週四', '週五', '週六', '週日'];
    final typeColor = _typeColor(today.type);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FitCoach', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(
              '${now.year}/${now.month}/${now.day}  ${weekdays[now.weekday]}',
              style: const TextStyle(fontSize: 13, color: Color(0xFF8E8E93), fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF30D158),
              child: const Text('K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('今日訓練', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF8E8E93))),
            const SizedBox(height: 12),

            // Main workout card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [typeColor.withOpacity(0.3), const Color(0xFF1A1A1A)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: typeColor.withOpacity(0.4), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(today.emoji, style: const TextStyle(fontSize: 36)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(today.title,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: typeColor, width: 1),
                            ),
                            child: Text(_typeLabel(today.type),
                                style: TextStyle(fontSize: 12, color: typeColor, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (today.exercises.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFF2C2C2E)),
                    const SizedBox(height: 12),
                    ...today.exercises.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(width: 6, height: 6,
                              decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(3))),
                          const SizedBox(width: 10),
                          Text(e.name, style: const TextStyle(fontSize: 15)),
                          const Spacer(),
                          Text('${e.sets}×${e.reps} ${e.unit}',
                              style: TextStyle(fontSize: 13, color: typeColor, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (today.type == 'rest')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Text('😴', style: TextStyle(fontSize: 40)),
                    SizedBox(height: 8),
                    Text('今天是休息日', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('好好放鬆，讓肌肉充分恢復！', style: TextStyle(color: Color(0xFF8E8E93))),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WorkoutScreen(program: today)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF30D158),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('開始訓練', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Weekly overview strip
            const Text('本週計畫', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF8E8E93))),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weeklyProgram.map((p) {
                final isToday = p.day == DateTime.now().weekday;
                final color = _typeColor(p.type);
                return Column(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: isToday ? color : color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: isToday ? Border.all(color: color, width: 2) : null,
                      ),
                      child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(height: 4),
                    Text(p.name.substring(1), style: TextStyle(
                      fontSize: 11,
                      color: isToday ? Colors.white : const Color(0xFF8E8E93),
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    )),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
