import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Mock data: generate last 21 days
    final days = List.generate(21, (i) {
      final date = now.subtract(Duration(days: 20 - i));
      final weekday = date.weekday;
      String status;
      if (date.isAfter(now)) {
        status = 'future';
      } else if (weekday == 7) {
        status = 'rest';
      } else {
        status = i % 3 == 0 ? 'missed' : 'completed';
      }
      return {'date': date, 'status': status};
    });

    Color statusColor(String s) {
      switch (s) {
        case 'completed': return const Color(0xFF30D158);
        case 'missed':    return const Color(0xFFFF453A);
        case 'rest':      return const Color(0xFF8E8E93);
        default:          return Colors.transparent;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('訓練歷史')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Legend
            Row(
              children: [
                _legend(const Color(0xFF30D158), '完成'),
                const SizedBox(width: 16),
                _legend(const Color(0xFFFF453A), '未完成'),
                const SizedBox(width: 16),
                _legend(const Color(0xFF8E8E93), '休息'),
              ],
            ),
            const SizedBox(height: 20),

            // Calendar grid
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['一','二','三','四','五','六','日']
                        .map((d) => Text(d, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 12)))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: days.length,
                    itemBuilder: (_, i) {
                      final day = days[i];
                      final date = day['date'] as DateTime;
                      final status = day['status'] as String;
                      final isToday = date.day == now.day && date.month == now.month;
                      return Container(
                        decoration: BoxDecoration(
                          color: statusColor(status).withOpacity(status == 'future' ? 0 : 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: isToday ? Border.all(color: const Color(0xFF30D158), width: 2) : null,
                        ),
                        child: Center(
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              color: status == 'future' ? const Color(0xFF3A3A3C) : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text('最近紀錄', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Recent workouts
            ...days.reversed.take(7).where((d) => d['status'] != 'future').map((d) {
              final date = d['date'] as DateTime;
              final status = d['status'] as String;
              final weekdays = ['', '週一', '週二', '週三', '週四', '週五', '週六', '週日'];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8, height: 40,
                      decoration: BoxDecoration(
                        color: statusColor(status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weekdays[date.weekday],
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${date.month}/${date.day}',
                            style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93))),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor(status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status == 'completed' ? '✅ 完成' : status == 'rest' ? '😴 休息' : '❌ 未完成',
                        style: TextStyle(fontSize: 12, color: statusColor(status)),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _legend(Color color, String label) => Row(children: [
    Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
    const SizedBox(width: 4),
    Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF8E8E93))),
  ]);
}
