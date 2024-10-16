import 'package:shared_preferences/shared_preferences.dart';

class SurveyManager {
  static const String _homeTabSessionKey = 'home_tab_session_count';
  static const String _detailSessionKey = 'detail_session_count';
  static const int _homeTabSurveySessionThreshold = 5;
  static const int _detailSurveySessionThreshold = 3;

  // Get the current session count for HomeTab screen
  static Future<int> getHomeTabSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_homeTabSessionKey) ?? 0;
  }

  // Increment the session count for HomeTab screen
  static Future<void> incrementHomeTabSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sessionCount = await getHomeTabSessionCount();
    prefs.setInt(_homeTabSessionKey, sessionCount + 1);
  }

  // Determine if the survey should be shown on HomeTab after 5 sessions
  static bool shouldShowHomeTabSurvey(int sessionCount) {
    return sessionCount >= _homeTabSurveySessionThreshold;
  }

  // Get the current session count for Detail screen
  static Future<int> getDetailScreenSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_detailSessionKey) ?? 0;
  }

  // Increment the session count for Detail screen
  static Future<void> incrementDetailScreenSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sessionCount = await getDetailScreenSessionCount();
    prefs.setInt(_detailSessionKey, sessionCount + 1);
  }

  // Determine if the survey should be shown on Detail screen after 3 sessions
  static bool shouldShowDetailSurvey(int sessionCount) {
    return sessionCount >= _detailSurveySessionThreshold;
  }

  // Reset session counts (optional)
  static Future<void> resetHomeTabSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_homeTabSessionKey, 0);
  }

  static Future<void> resetDetailScreenSessionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_detailSessionKey, 0);
  }
}
