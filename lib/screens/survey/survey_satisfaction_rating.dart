import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveySatisfactionRating extends StatefulWidget {
  final VoidCallback onClose;

  SurveySatisfactionRating({required this.onClose});

  @override
  _SurveyTrueFalseState createState() => _SurveyTrueFalseState();
}

class _SurveyTrueFalseState extends State<SurveySatisfactionRating> {
  String selectedOption = '';
  String hoveredOption = '';

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void handleOptionSelection(String optionKey) {
    setState(() {
      selectedOption = optionKey;  // Store the localization key
    });
  }

  // Method to send data to Firestore
  Future<void> _sendSurveyResponse() async {
    try {
      await _firestore.collection('survey_responses').add({
        'survey_type': 'SatisfactionRating',  // You can use different survey types
        'response': selectedOption,  // Store the localization key
        'timestamp': Timestamp.now(),
      });
      widget.onClose();
    } catch (e) {
      print("Error saving survey response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50),

                  // Question Text
                  Text(
                    AppLocalizations.of(context).translate('satisfaction_question'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Emoji Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // "Nope" Option
                      GestureDetector(
                        onTap: () => handleOptionSelection('nope'),  // Store the key
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = 'nope'),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == 'nope' || hoveredOption == 'nope'
                                      ? Colors.red.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_very_dissatisfied_rounded,
                                  size: 40,
                                  color: selectedOption == 'nope' ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Space between icon and text
                            Text(AppLocalizations.of(context).translate('nope')),
                          ],
                        ),
                      ),

                      // "It’s okay" Option
                      GestureDetector(
                        onTap: () => handleOptionSelection('okay'),  // Store the key
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = 'okay'),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == 'okay' || hoveredOption == 'okay'
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_neutral_rounded,
                                  size: 40,
                                  color: selectedOption == 'okay' ? Colors.blue : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(AppLocalizations.of(context).translate('okay')),
                          ],
                        ),
                      ),

                      // "100% agree" Option
                      GestureDetector(
                        onTap: () => handleOptionSelection('agree'),  // Store the key
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = 'agree'),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == 'agree' || hoveredOption == 'agree'
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_satisfied_alt_rounded,
                                  size: 40,
                                  color: selectedOption == 'agree' ? Colors.orange : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(AppLocalizations.of(context).translate('agree')),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Buttons (Ask me later, Send)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: widget.onClose, // Close the survey
                        child: Text(
                          AppLocalizations.of(context).translate('ask_me_later'),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedOption.isNotEmpty) {
                            _sendSurveyResponse(); // Send data to Firestore
                          }
                        },
                        child: Text(AppLocalizations.of(context).translate('send_bu')),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Close Icon (Top Right)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: widget.onClose, // Close survey when icon is pressed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
