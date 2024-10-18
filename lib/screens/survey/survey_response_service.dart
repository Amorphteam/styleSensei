import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyResponseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendSurveyResponse(String surveyType, String response) async {
    try {
      await _firestore.collection('survey_responses').add({
        'survey_type': surveyType,
        'response': response,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print("Error saving survey response: $e");
    }
  }
}
