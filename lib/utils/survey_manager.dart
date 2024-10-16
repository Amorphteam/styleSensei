import 'package:shared_preferences/shared_preferences.dart';

class SurveyManager {
  static const String _sessionKey = 'session_count';
  static const int _multistepSurveySessionThreshold = 5;

  // Get the current session count
  static Future<int> getSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sessionKey) ?? 0;
  }

  // Increment the session count
  static Future<void> incrementSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sessionCount = await getSessionCount();
    prefs.setInt(_sessionKey, sessionCount + 1);
  }

  // Determine if SurveyMultistep should be shown
  static bool shouldShowSurveyMultistep(int sessionCount) {
    return sessionCount >= _multistepSurveySessionThreshold;
  }

  // Reset the session count (optional)
  static Future<void> resetSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_sessionKey, 0);
  }
}
