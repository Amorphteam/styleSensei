import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance; // Use .instance

  // Generic method to log events
  static Future<void> logEvent(String eventName, Map<String, dynamic> parameters) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
      print("Event: $eventName logged with parameters: $parameters");
    } catch (e) {
      print("Error logging event: $eventName, Error: $e");
    }
  }

  // Specific method for logging style selection
  static Future<void> logStyleSelection(int styleTag) async {
    await logEvent('select_favorite_style', {
      'style_tag': styleTag,
    });
  }

  // Specific method for logging final selection
  static Future<void> logFinalStyleSelection(List<int> selectedStyles) async {
    await logEvent('final_style_selection', {
      'selected_styles': selectedStyles.join(','), // Send selected styles as a string
    });
  }


  // Specific method for logging color tone selection
  static Future<void> logColorToneSelection(int colorToneTag, bool isSelected) async {
    await logEvent(
      isSelected ? 'deselect_color_tone' : 'select_color_tone',
      {'color_tone_tag': colorToneTag},
    );
  }

  // Specific method for logging when the user proceeds to the next screen or saves selections
  static Future<void> logProceedEvent(List<int> selectedColorTones, bool isFromSettings) async {
    await logEvent(
      isFromSettings ? 'save_color_tone_selection' : 'proceed_color_tone_selection',
      {'selected_color_tones': selectedColorTones.join(',')},
    );
  }

  // Specific method for logging body type selection
  static Future<void> logBodyTypeSelection(int bodyTypeTag) async {
    await logEvent('select_body_type', {'body_type_tag': bodyTypeTag});
  }

  // Specific method for logging when proceeding to the next screen or saving selections
  static Future<void> logProceedEventBody(int selectedBodyType, bool isFromSettings) async {
    await logEvent(
      isFromSettings ? 'save_body_type_selection' : 'proceed_body_type_selection',
      {'selected_body_type': selectedBodyType},
    );
  }


  // Specific method for logging AI Assistant queries
  static Future<void> logAiAssistantQuery(String query) async {
    // Truncate the query to 50 characters
    String truncatedQuery = query.length > 50 ? query.substring(0, 50) + '...' : query;

    await logEvent('use_ai_assistant', {
      'query_text': truncatedQuery,
    });
  }
}
