import 'package:shared_preferences/shared_preferences.dart';

class SurveyConfig {
  final String surveyId;
  final int initialDelay;
  final int closeDelay;
  final int askMeLaterDelay;

  SurveyConfig({
    required this.surveyId,
    required this.initialDelay,
    required this.closeDelay,
    required this.askMeLaterDelay,
  });
}
