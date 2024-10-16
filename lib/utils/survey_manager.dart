import 'package:shared_preferences/shared_preferences.dart';

class SurveyManager {
  static const String _homeTabSessionKey = 'home_tab_session_count';
  static const String _detailSessionKey = 'detail_session_count';
  static const String _homeTabInteractionKey = 'home_tab_interaction_count';
  static const String _purchaseLinkClickCountKey = 'purchase_link_click_count';
  static const String _lastSatisfactionSurveyTimestampKey = 'last_satisfaction_survey_timestamp';

  static const int _homeTabSurveySessionThreshold = 5;
  static const int _detailSurveySessionThreshold = 3;
  static const int _interactionThreshold = 10;
  static const int _purchaseLinkClickThreshold = 2;
  static const int _weeksThreshold = 2;

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

  // -------------------
  // Logic for Satisfaction Survey on HomeTab (after two weeks or 10 interactions)
  // -------------------

  // Get the interaction count for HomeTab
  static Future<int> getHomeTabInteractionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_homeTabInteractionKey) ?? 0;
  }

  // Increment interaction count for HomeTab
  static Future<void> incrementHomeTabInteractionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int interactionCount = await getHomeTabInteractionCount();
    prefs.setInt(_homeTabInteractionKey, interactionCount + 1);
  }

  // Reset interaction count for HomeTab
  static Future<void> resetHomeTabInteractionCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_homeTabInteractionKey, 0);
  }

  // Get the timestamp of the last satisfaction survey
  static Future<int> getLastSatisfactionSurveyTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastSatisfactionSurveyTimestampKey) ?? 0;
  }

  // Set the timestamp of the current satisfaction survey
  static Future<void> setLastSatisfactionSurveyTimestamp(int timestamp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_lastSatisfactionSurveyTimestampKey, timestamp);
  }

  // Determine if two weeks have passed since the last satisfaction survey
  static Future<bool> isTwoWeeksSinceLastSurvey() async {
    int lastSurveyTimestamp = await getLastSatisfactionSurveyTimestamp();
    if (lastSurveyTimestamp == 0) return true; // No survey has been shown yet

    int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    int twoWeeksInMillis = _weeksThreshold * 7 * 24 * 60 * 60 * 1000;

    return (currentTimestamp - lastSurveyTimestamp) >= twoWeeksInMillis;
  }

  // Determine if the Satisfaction Survey should be shown based on time or interaction count
  static Future<bool> shouldShowSatisfactionSurvey() async {
    int interactionCount = await getHomeTabInteractionCount();
    bool isTwoWeeks = await isTwoWeeksSinceLastSurvey();

    // Show survey if either condition is met
    return interactionCount >= _interactionThreshold || isTwoWeeks;
  }

  // -------------------
  // Logic for BinaryChoice Survey after two purchase link clicks
  // -------------------

  // Get the purchase link click count
  static Future<int> getPurchaseLinkClickCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_purchaseLinkClickCountKey) ?? 0;
  }

  // Increment purchase link click count
  static Future<void> incrementPurchaseLinkClickCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int clickCount = await getPurchaseLinkClickCount();
    prefs.setInt(_purchaseLinkClickCountKey, clickCount + 1);
  }

  // Determine if BinaryChoice Survey should be shown after two purchase link clicks
  static Future<bool> shouldShowBinaryChoiceSurvey() async {
    int clickCount = await getPurchaseLinkClickCount();
    return clickCount >= _purchaseLinkClickThreshold;
  }

  // Reset the purchase link click count (optional)
  static Future<void> resetPurchaseLinkClickCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_purchaseLinkClickCountKey, 0);
  }
}
