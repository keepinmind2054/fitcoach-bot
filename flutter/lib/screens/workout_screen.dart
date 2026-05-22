import 'package:flutter/material.dart';
import 'dart:async';
import '../constants/program.dart';
import '../services/api_service.dart';

class WorkoutScreen extends StatefulWidget {
  final DayProgram program;
  const WorkoutScreen({super.key, required this.program});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late List<bool> _checked;
  late List<String> _actualReps;
  late Timer _timer;
  int _seconds = 0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _checked = List.filled(widget.program.exercises.length, false);
    _actualReps = List.filled(widget.program.exercises.length, '');
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _timeString {
    final m = _seconds ~/ 60;
    final s = _seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  int get _completedCount => _checked.where((c) => c).length;

  Future<void> _finish() async {
    setState(() => _loading = true);
    final exercises = widget.program.exercises
        .asMap()
        .entries
        .map((e) => {
              'name': e.value.name,
              'completed': _checked[e.key],
              'actual_reps': _actualReps[e.key].isNotEmpty ? _actualReps[e.key] : '${e.value.reps}',
              'sets': e.value.sets,
            })
        .toList();

    final result = await ApiService.logWorkout(
      telegramId: 'user123',
      exercisesCompleted: exercises,
      durationMinutes: _seconds ~/ 60,
    );
    setState(() => _loading = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(children: [
            Text('🎉 ', style: TextStyle(fontSize: 24)),
            Text('訓練完成！', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result['ai_feedback'] ?? '太棒了！繼續加油！💪',
                  style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFFE5E5E7)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statChip('⏱', _timeString, '時間'),
                  _statChip('✅', '$_completedCount/${widget.program.exercises.length}', '動作'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () { Navigator.pop(context); Navigator.pop(context); },
              child: const Text('繼續加油！', style: TextStyle(color: Color(0xFF30D158), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }
  }

  Widget _statChip(String emoji, String value, String label) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(widget.program.type);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.program.emoji} ${widget.program.title}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(_timeString,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: widget.program.exercises.isEmpty ? 1.0 : _completedCount / widget.program.exercises.length,
            backgroundColor: const Color(0xFF2C2C2E),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 3,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: widget.program.exercises.length,
              itemBuilder: (context, i) {
                final ex = widget.program.exercises[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _checked[i] ? color.withOpacity(0.15) : const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _checked[i] ? color : const Color(0xFF2C2C2E),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _checked[i] = !_checked[i]),
                        child: Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(
                            color: _checked[i] ? color : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _checked[i] ? color : const Color(0xFF8E8E93), width: 1.5),
                          ),
                          child: _checked[i]
                              ? const Icon(Icons.check_rounded, size: 18, color: Colors.black)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ex.name,
                                style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600,
                                  decoration: _checked[i] ? TextDecoration.lineThrough : null,
                                  color: _checked[i] ? const Color(0xFF8E8E93) : Colors.white,
                                )),
                            Text('目標：${ex.sets} 組 × ${ex.reps} ${ex.unit}',
                                style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93))),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: color, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: '${ex.reps}',
                            hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
                            filled: true,
                            fillColor: const Color(0xFF0F0F0F),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (v) => _actualReps[i] = v,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _completedCount == 0 || _loading ? null : _finish,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: const Color(0xFF2C2C2E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : Text(
                        '完成訓練 ($_completedCount/${widget.program.exercises.length})',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'strength': return const Color(0xFFFF6B6B);
      case 'cardio':   return const Color(0xFF4ECDC4);
      case 'hiit':     return const Color(0xFFFFD93D);
      case 'core':     return const Color(0xFF30D158);
      default:         return const Color(0xFF8E8E93);
    }
  }
}
