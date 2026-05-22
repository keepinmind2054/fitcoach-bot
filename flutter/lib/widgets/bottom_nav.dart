import 'package:flutter/material.dart';

class FitCoachBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FitCoachBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(color: Color(0xFF2C2C2E), width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFF30D158),
        unselectedItemColor: const Color(0xFF8E8E93),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 22)),
            activeIcon: Text('🏠', style: TextStyle(fontSize: 24)),
            label: '首頁',
          ),
          BottomNavigationBarItem(
            icon: Text('📅', style: TextStyle(fontSize: 22)),
            activeIcon: Text('📅', style: TextStyle(fontSize: 24)),
            label: '紀錄',
          ),
          BottomNavigationBarItem(
            icon: Text('📊', style: TextStyle(fontSize: 22)),
            activeIcon: Text('📊', style: TextStyle(fontSize: 24)),
            label: '報告',
          ),
          BottomNavigationBarItem(
            icon: Text('⚙️', style: TextStyle(fontSize: 22)),
            activeIcon: Text('⚙️', style: TextStyle(fontSize: 24)),
            label: '設定',
          ),
        ],
      ),
    );
  }
}
