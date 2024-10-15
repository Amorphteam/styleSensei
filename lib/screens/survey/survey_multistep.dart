import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

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

  // List of survey steps (questions)
  final List<String> surveyQuestions = [
    'outfit_alignment',  // Localization key
    'discover_clothing_suitability',  // Localization key
  ];

  // Method to handle option selection
  void handleOptionSelection(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  // Method to go to the next step
  void nextStep() {
    if (currentStep < surveyQuestions.length - 1) {
      setState(() {
        currentStep++;
        selectedOption = ''; // Reset selection for the next step
      });
    } else {
      // Handle submission (e.g., send the results to a server)
      widget.onClose(); // Close the survey after submission
    }
  }

  // Method to go to the previous step
  void previousStep() {
    if (currentStep > 0) {
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

                  // Progress Indicator (Simulated by colored lines)
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

                  // Question Text
                  Text(
                    AppLocalizations.of(context).translate(surveyQuestions[currentStep]),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Emoji Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildEmojiOption(
                        AppLocalizations.of(context).translate('way_off'),
                        Icons.sentiment_very_dissatisfied_rounded,
                        Colors.red,
                      ),
                      _buildEmojiOption(
                        AppLocalizations.of(context).translate('meh_kinda'),
                        Icons.sentiment_neutral_rounded,
                        Colors.blue,
                      ),
                      _buildEmojiOption(
                        AppLocalizations.of(context).translate('totally_me'),
                        Icons.sentiment_satisfied_alt_rounded,
                        Colors.orange,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Buttons (Previous, Next/Submit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous button
                      if (currentStep > 0)
                        TextButton(
                          onPressed: previousStep,
                          child: Text(
                            AppLocalizations.of(context).translate('previous'),
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      if (currentStep == 0) SizedBox(), // Placeholder to align buttons

                      // Next/Submit button
                      ElevatedButton(
                        onPressed: selectedOption.isNotEmpty ? nextStep : null, // Only enable when an option is selected
                        child: Text(
                          currentStep == surveyQuestions.length - 1
                              ? AppLocalizations.of(context).translate('send_bu')
                              : AppLocalizations.of(context).translate('next'),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                          selectedOption.isNotEmpty ? Colors.black : Colors.grey,
                          padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  // Widget to build emoji options
  Widget _buildEmojiOption(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => handleOptionSelection(label),
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => hoveredOption = label),
            onExit: (_) => setState(() => hoveredOption = ''),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedOption == label || hoveredOption == label
                    ? color.withOpacity(0.2)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: selectedOption == label ? color : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 5), // Space between icon and text
          Text(label),
        ],
      ),
    );
  }
}
