import 'package:flutter/material.dart';
import '../../utils/AppLocalizations.dart';
import 'survey_config.dart';
import 'base_survey_widget.dart';

class SurveyMultistep extends BaseSurveyWidget {
  SurveyMultistep({
    required VoidCallback onClose,
    required VoidCallback onSend,
    required VoidCallback onAskMeLater,
  }) : super(
    surveyConfig: SurveyConfig(
      surveyId: 'MultiStep',
      initialDelay: 5,
      closeDelay: 15,
      askMeLaterDelay: 10,
    ),
    onClose: onClose,
    onAskMeLater: onAskMeLater,
    onSend: onSend,
  );

  @override
  _SurveyMultistepState createState() => _SurveyMultistepState();
}
class _SurveyMultistepState extends BaseSurveyState<SurveyMultistep> {
  int currentStep = 0;

  final List<String> surveyQuestions = [
    'survey_initial_message',
    'outfit_alignment',
    'discover_clothing_suitability',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < surveyQuestions.length; i++)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            height: 4,
                            color: i <= currentStep ? Colors.red : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  currentStep == 0
                      ? Text(
                    AppLocalizations.of(context).translate('survey_initial_message'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                      : Text(
                    AppLocalizations.of(context).translate(surveyQuestions[currentStep]),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  if (currentStep != 0) ...[
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildOption('way_off', Icons.sentiment_very_dissatisfied_rounded, Colors.red),
                        buildOption('meh_kinda', Icons.sentiment_neutral_rounded, Colors.blue),
                        buildOption('totally_me', Icons.sentiment_satisfied_alt_rounded, Colors.orange),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: previousStepOrAskMeLater,
                        child: Text(
                          currentStep == 0
                              ? AppLocalizations.of(context).translate('nah_not_in_the_mood')
                              : AppLocalizations.of(context).translate('previous'),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: currentStep == 0 || selectedOption.isNotEmpty ? nextStep : null,
                        child: Text(
                          currentStep == 0
                              ? AppLocalizations.of(context).translate('absolutely') // Show "Absolutely" on the first step
                              : currentStep == surveyQuestions.length - 1
                              ? AppLocalizations.of(context).translate('send_bu') // Show "Send" on the last step
                              : AppLocalizations.of(context).translate('next'), // Show "Next" for other steps
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: selectedOption.isNotEmpty || currentStep == 0 ? Colors.black : Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: widget.onClose,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void nextStep() {
    if (currentStep < surveyQuestions.length - 1) {
      setState(() {
        currentStep++;
        selectedOption = '';
      });
    } else {
      sendSurveyResponse();
    }
  }

  void previousStepOrAskMeLater() {
    if (currentStep == 0) {
      widget.onAskMeLater();
    } else {
      setState(() {
        currentStep--;
        selectedOption = '';
      });
    }
  }

  @override
  Future<void> sendSurveyResponse() async {
    // Override the method to handle multi-step survey responses
    await surveyResponseService.sendSurveyResponse(
      widget.surveyConfig.surveyId,
      selectedOption,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context).translate('feedback_received'),
        ),
        backgroundColor: Colors.black87,
      ),
    );

    widget.onSend(); // Close the survey after submission
  }
}
