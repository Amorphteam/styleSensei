import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyResponseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> sendSurveyResponse(String surveyType, String response) async {
    try {
      // Attempt to send the survey response with a timeout
      await _firestore
          .collection('survey_responses')
          .add({
        'survey_type': surveyType,
        'response': response,
        'timestamp': Timestamp.now(),
      })
          .timeout(Duration(seconds: 2)); // Timeout after 5 seconds

      return true; // Return true if the operation succeeds
    } catch (e) {
      print("Error saving survey response: $e");
      return false; // Return false if an error occurs
    }
  }
}
