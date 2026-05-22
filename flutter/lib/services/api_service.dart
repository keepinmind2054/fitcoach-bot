import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  static Future<Map<String, dynamic>> initUser(
      String telegramId, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/init'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'telegram_id': telegramId, 'name': name}),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'telegram_id': telegramId, 'name': name, 'is_new': false};
    }
  }

  static Future<Map<String, dynamic>> getTodayWorkout(
      String telegramId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/workout/today/$telegramId'));
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> logWorkout({
    required String telegramId,
    required List<Map<String, dynamic>> exercisesCompleted,
    required int durationMinutes,
    String notes = '',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/workout/log'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'telegram_id': telegramId,
          'exercises_completed': exercisesCompleted,
          'duration_minutes': durationMinutes,
          'notes': notes,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {
        'log_id': 0,
        'ai_feedback': '太棒了！今天的訓練完成得很好！繼續保持，你越來越強了！💪'
      };
    }
  }

  static Future<List<dynamic>> getHistory(String telegramId) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/workout/history/$telegramId'));
      return jsonDecode(response.body);
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>> getWeeklyReport(
      String telegramId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/analysis/weekly-report/$telegramId'));
      return jsonDecode(response.body);
    } catch (e) {
      return {
        'completion_rate': 0.0,
        'total_workouts': 0,
        'ai_summary': '開始記錄你的訓練，AI 教練會幫你分析進步！',
      };
    }
  }
}
