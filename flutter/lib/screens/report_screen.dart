import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final weekData = [
      {'week': '3週前', 'rate': 0.57},
      {'week': '2週前', 'rate': 0.71},
      {'week': '上週', 'rate': 0.85},
      {'week': '本週', 'rate': 0.43},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('訓練報告')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This week completion
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Progress circle (manual)
                  SizedBox(
                    width: 90, height: 90,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: 3 / 7,
                          strokeWidth: 8,
                          backgroundColor: const Color(0xFF2C2C2E),
                          valueColor: const AlwaysStoppedAnimation(Color(0xFF30D158)),
                        ),
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('3/7', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text('天', style: TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('本週進度', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _statRow('🏆', '完成率', '43%'),
                        _statRow('🔥', '訓練天數', '3 天'),
                        _statRow('⏱', '總時長', '~2.5 小時'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // AI Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1C2340), Color(0xFF1A1A1A)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF30D158).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Text('🤖', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    const Text('AI 教練分析', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF30D158))),
                  ]),
                  const SizedBox(height: 12),
                  const Text(
                    '本週你完成了 3 次訓練，表現穩定！特別是週三的下肢訓練做得很好，深蹲次數有所提升。\n\n建議下週重點：嘗試增加有氧訓練的強度，每次跑步時間延長 5 分鐘，同時保持重訓的規律性。你的進步非常明顯，繼續加油！💪',
                    style: TextStyle(fontSize: 14, height: 1.6, color: Color(0xFFE5E5E7)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4-week bar chart
            const Text('近四週完成率', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: weekData.map((w) {
                  final rate = w['rate'] as double;
                  final isLatest = w['week'] == '本週';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${(rate * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold,
                            color: isLatest ? const Color(0xFF30D158) : const Color(0xFF8E8E93),
                          )),
                      const SizedBox(height: 6),
                      Container(
                        width: 40,
                        height: 120 * rate,
                        decoration: BoxDecoration(
                          color: isLatest ? const Color(0xFF30D158) : const Color(0xFF30D158).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(w['week'] as String,
                          style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Text('💬', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '"每一滴汗水都在塑造更好的你。"',
                      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFF8E8E93)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String emoji, String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 14)),
      const SizedBox(width: 6),
      Text('$label  ', style: const TextStyle(fontSize: 13, color: Color(0xFF8E8E93))),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
    ]),
  );
}
