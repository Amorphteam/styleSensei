import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style_sensei/screens/survey/survey_binary_choice.dart';
import 'package:style_sensei/screens/survey/survey_multiple_choice.dart';
import '../screens/survey/survey_config.dart';
import '../screens/survey/survey_multistep.dart';

class SurveyHelper {
  static const String sessionCountKey = 'sessionCount';
  static const String lastSurveySessionKey = 'lastSurveySession';
  static const String surveyCompletedKey = 'surveyCompleted';
  static const String sessionCountKeyMultipleChoise = 'sessionCountMultipleChoise';
  static const String lastSurveySessionKeyMultipleChoise = 'lastSurveySessionMultipleChoise';
  static const String surveyCompletedKeyMultipleChoise = 'surveyCompletedMultipleChoise';
  static const String sessionCountKeyPurchase = 'sessionCountPurchase';
  static const String lastSurveySessionKeyPurchase = 'lastSurveySessionPurchase';
  static const String surveyCompletedKeyPurchase = 'surveyCompletedPurchase';

  Future<bool> shouldShowSurvey(SurveyConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionCount = prefs.getInt(sessionCountKey) ?? 0;
    var lastSurveySession = prefs.getInt(lastSurveySessionKey) ?? 0;
    if (lastSurveySession == 0) {
      prefs.setInt(lastSurveySessionKey, config.initialDelay);
      lastSurveySession = config.initialDelay;
    }
    final isSurveyCompleted = prefs.getBool(surveyCompletedKey) ?? false;

    // Show the survey only if it hasn't been completed and the session count is greater than or equal to the next scheduled session
    return !isSurveyCompleted && (sessionCount >= lastSurveySession);
  }


  Future<bool> shouldShowSurveyMultipleChoise(SurveyConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionCount = prefs.getInt(sessionCountKeyMultipleChoise) ?? 0;
    var lastSurveySession = prefs.getInt(lastSurveySessionKeyMultipleChoise) ?? 0;
    if (lastSurveySession == 0) {
      prefs.setInt(lastSurveySessionKeyMultipleChoise, config.initialDelay);
      lastSurveySession = config.initialDelay;
    }

    final isSurveyCompleted = prefs.getBool(surveyCompletedKeyMultipleChoise) ?? false;

    // Show the survey only if it hasn't been completed and the session count is greater than or equal to the next scheduled session
    return !isSurveyCompleted && (sessionCount >= lastSurveySession);
  }
  Future<bool> shouldShowSurveyPurchase(SurveyConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionCount = prefs.getInt(sessionCountKeyPurchase) ?? 0;
    var lastSurveySession = prefs.getInt(lastSurveySessionKeyPurchase) ?? 0;
    if (lastSurveySession == 0) {
      prefs.setInt(lastSurveySessionKeyPurchase, config.initialDelay);
      lastSurveySession = config.initialDelay;
    }

    final isSurveyCompleted = prefs.getBool(surveyCompletedKeyPurchase) ?? false;

    // Show the survey only if it hasn't been completed and the session count is greater than or equal to the next scheduled session
    return !isSurveyCompleted && (sessionCount >= lastSurveySession);
  }

  // Increment the session count whenever HomeTab is opened
  Future<void> incrementSessionCount() async {
    final prefs = await SharedPreferences.getInstance();
    int sessionCount = prefs.getInt(sessionCountKey) ?? 0;
    sessionCount++;
    await prefs.setInt(sessionCountKey, sessionCount);
  }


  Future<void> incrementSessionCountMultipleChoise() async {
    final prefs = await SharedPreferences.getInstance();
    int sessionCount = prefs.getInt(sessionCountKeyMultipleChoise) ?? 0;
    sessionCount++;
    await prefs.setInt(sessionCountKeyMultipleChoise, sessionCount);
  }
  Future<void> incrementSessionCountPurchase() async {
    final prefs = await SharedPreferences.getInstance();
    int sessionCount = prefs.getInt(sessionCountKeyPurchase) ?? 0;
    sessionCount++;
    await prefs.setInt(sessionCountKeyPurchase, sessionCount);
  }

  // Mark the survey as completed
  Future<void> markSurveyAsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(surveyCompletedKey, true);
  }


  // Mark the survey as completed
  Future<void> markSurveyAsCompletedMultipleChoise() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(surveyCompletedKeyMultipleChoise, true);
  }
  Future<void> markSurveyAsCompletedPurchase() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(surveyCompletedKeyPurchase, true);
  }


  // Show the SurveyMultistep widget
  void showSurveyMultistep({required BuildContext context, required VoidCallback onClose, required VoidCallback onAskMeLater, required VoidCallback onSend}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SurveyMultistep(
          onClose: () {
            onClose();
            Navigator.of(context).pop(); // Close the dialog
          },
          onAskMeLater: () {
            onAskMeLater();
            Navigator.of(context).pop(); // Close the dialog
          }, onSend: () {
            onSend();
            Navigator.of(context).pop();
        },
        );
      },
    );
  }


  void showSurveyMultipleChoise({required BuildContext context, required VoidCallback onClose, required VoidCallback onAskMeLater, required VoidCallback onSend}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SurveyMultipleChoice(
          onClose: () {
            onClose();
            Navigator.of(context).pop(); // Close the dialog
          },
          onAskMeLater: () {
            onAskMeLater();
            Navigator.of(context).pop(); // Close the dialog
          }, onSend: () {
          onSend();
          Navigator.of(context).pop();
        },
        );
      },
    );
  }

  void showSurveyPurchase({required BuildContext context, required VoidCallback onClose, required VoidCallback onAskMeLater, required VoidCallback onSend}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SurveyBinaryChoice(
          onClose: () {
            onClose();
            Navigator.of(context).pop(); // Close the dialog
          },
          onAskMeLater: () {
            onAskMeLater();
            Navigator.of(context).pop(); // Close the dialog
          }, onSend: () {
          onSend();
          Navigator.of(context).pop();
        },
        );
      },
    );
  }

  // Reset the next survey session to a specific delay from now
  Future<void> resetNextSurveySession(int delayInSessions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sessionCountKey, 0);
    await prefs.setInt(lastSurveySessionKey, delayInSessions);
  }


  Future<void> resetNextSurveySessionMultipleChoise(int delayInSessions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sessionCountKeyMultipleChoise, 0);
    await prefs.setInt(lastSurveySessionKeyMultipleChoise, delayInSessions);
  }

  Future<void> resetNextSurveySessionPurchase(int delayInSessions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(sessionCountKeyPurchase, 0);
    await prefs.setInt(lastSurveySessionKeyPurchase, delayInSessions);
  }
}
