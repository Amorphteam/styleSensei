import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyMultistep extends StatefulWidget {
  final VoidCallback onClose;

  SurveyMultistep({required this.onClose});

  @override
  _MultiStepSurveyState createState() => _MultiStepSurveyState();
}

class _MultiStepSurveyState extends State<SurveyMultistep> {
  int currentStep = 0;
  String selectedOption = '';
  String hoveredOption = '';

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of survey steps (questions)
  final List<String> surveyQuestions = [
    'survey_initial_message', // Initial message dialog
    'outfit_alignment',  // Localization key
    'discover_clothing_suitability',  // Localization key
  ];

  // Method to handle option selection
  void handleOptionSelection(String optionKey) {
    setState(() {
      selectedOption = optionKey;
    });
  }

  // Method to send data to Firestore
  Future<void> _sendSurveyResponse() async {
    try {
      await _firestore.collection('survey_responses').add({
        'survey_type': 'MultiStep',  // Use consistent survey types
        'responses': _buildResponses(),
        'timestamp': Timestamp.now(),
      });
      widget.onClose(); // Close the survey after submission
    } catch (e) {
      print("Error saving survey response: $e");
    }
  }

  // Build the responses for each step
  Map<String, dynamic> _buildResponses() {
    return {
      surveyQuestions[currentStep]: selectedOption,  // Store the key instead of the translated value
    };
  }

  // Method to go to the next step
  void nextStep() {
    if (currentStep < surveyQuestions.length - 1) {
      setState(() {
        currentStep++;
        selectedOption = ''; // Reset selection for the next step
      });
    } else {
      // Final step - submit the data
      _sendSurveyResponse();  // Send data to Firestore
    }
  }

  // Method to go to the previous step or handle "Nah, I'm not in the mood"
  void previousStepOrAskMeLater() {
    if (currentStep == 0) {
      widget.onClose();  // Close survey when "Nah, I'm not in the mood" is clicked
    } else {
      setState(() {
        currentStep--;
        selectedOption = ''; // Reset selection for the previous step
      });
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),

                  // Progress Indicator (Including the initial message dialog)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < surveyQuestions.length; i++)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            height: 4,
                            color: i <= currentStep
                                ? Colors.red
                                : Colors.grey.shade300, // Progress color
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Conditionally show the initial dialog or the survey questions
                  currentStep == 0
                      ? Text(
                    AppLocalizations.of(context).translate('survey_initial_message'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                      : Text(
                    AppLocalizations.of(context).translate(surveyQuestions[currentStep]),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  if (currentStep != 0) ...[
                    SizedBox(height: 20),
                    // Emoji Options (Survey Steps)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildEmojiOption(
                          'way_off',  // Localization key for "Way off"
                          Icons.sentiment_very_dissatisfied_rounded,
                          Colors.red,
                        ),
                        _buildEmojiOption(
                          'meh_kinda',  // Localization key for "Meh, kinda"
                          Icons.sentiment_neutral_rounded,
                          Colors.blue,
                        ),
                        _buildEmojiOption(
                          'totally_me',  // Localization key for "Totally me"
                          Icons.sentiment_satisfied_alt_rounded,
                          Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],

                  // Navigation Buttons (Nah, I'm not in the mood / Previous, Next/Submit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // "Nah, I'm not in the mood" or "Previous" button
                      TextButton(
                        onPressed: previousStepOrAskMeLater,
                        child: Text(
                          currentStep == 0
                              ? AppLocalizations.of(context).translate('nah_not_in_the_mood')
                              : AppLocalizations.of(context).translate('previous'),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),

                      // Next/Submit button
                      ElevatedButton(
                        onPressed: currentStep == 0 || selectedOption.isNotEmpty ? nextStep : null,  // Allow advancing from the first dialog
                        child: Text(
                          currentStep == surveyQuestions.length - 1
                              ? AppLocalizations.of(context).translate('send_bu')
                              : AppLocalizations.of(context).translate('next'),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                          selectedOption.isNotEmpty || currentStep == 0 ? Colors.black : Colors.grey,
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

  // Widget to build emoji options with localization keys
  Widget _buildEmojiOption(String optionKey, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => handleOptionSelection(optionKey),  // Send key instead of value
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => hoveredOption = optionKey),
            onExit: (_) => setState(() => hoveredOption = ''),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedOption == optionKey || hoveredOption == optionKey
                    ? color.withOpacity(0.2)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: selectedOption == optionKey ? color : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 5), // Space between icon and text
          Text(AppLocalizations.of(context).translate(optionKey)),  // Display the translated value
        ],
      ),
    );
  }
}
