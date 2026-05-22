import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  String _notifyTime = '09:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF30D158),
                    child: const Text('K', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ke', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('初學者 · 第 1 週', style: TextStyle(fontSize: 13, color: Color(0xFF8E8E93))),
                      SizedBox(height: 4),
                      Row(children: [
                        Icon(Icons.local_fire_department, size: 16, color: Color(0xFFFF9F0A)),
                        SizedBox(width: 4),
                        Text('連續 3 天！', style: TextStyle(fontSize: 12, color: Color(0xFFFF9F0A))),
                      ]),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text('提醒設定', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
            const SizedBox(height: 8),

            _settingCard([
              _toggleRow('每日訓練提醒', _notifications, (v) => setState(() => _notifications = v)),
              if (_notifications) ...[
                const Divider(color: Color(0xFF2C2C2E)),
                _arrowRow('提醒時間', _notifyTime, () {}),
              ],
            ]),

            const SizedBox(height: 16),
            const Text('訓練設定', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
            const SizedBox(height: 8),

            _settingCard([
              _arrowRow('訓練等級', '初學者', () {}),
              const Divider(color: Color(0xFF2C2C2E)),
              _arrowRow('訓練計畫', '7天綜合計畫', () {}),
              const Divider(color: Color(0xFF2C2C2E)),
              _arrowRow('每週開始', '週一', () {}),
            ]),

            const SizedBox(height: 16),
            const Text('關於', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
            const SizedBox(height: 8),

            _settingCard([
              _arrowRow('FitCoach 版本', 'v1.0.0', () {}),
              const Divider(color: Color(0xFF2C2C2E)),
              _arrowRow('隱私政策', '', () {}),
              const Divider(color: Color(0xFF2C2C2E)),
              _arrowRow('意見回饋', '', () {}),
            ]),

            const SizedBox(height: 32),
            Center(
              child: Text('Made with ❤️ by Ke Lab',
                  style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingCard(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(children: children),
  );

  Widget _toggleRow(String label, bool value, ValueChanged<bool> onChanged) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(children: [
      Text(label, style: const TextStyle(fontSize: 15)),
      const Spacer(),
      Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF30D158)),
    ]),
  );

  Widget _arrowRow(String label, String value, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(children: [
        Text(label, style: const TextStyle(fontSize: 15)),
        const Spacer(),
        if (value.isNotEmpty) Text(value, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
        const SizedBox(width: 4),
        const Icon(Icons.chevron_right_rounded, color: Color(0xFF8E8E93), size: 20),
      ]),
    ),
  );
}
