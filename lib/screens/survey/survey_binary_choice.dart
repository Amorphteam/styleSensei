import 'package:flutter/material.dart';

import '../../utils/AppLocalizations.dart';
import 'survey_config.dart';
import 'base_survey_widget.dart';

class SurveyBinaryChoice extends BaseSurveyWidget {
  SurveyBinaryChoice({
    required VoidCallback onClose,
    required VoidCallback onSend,
    required VoidCallback onAskMeLater,
  }) : super(
    surveyConfig: SurveyConfig(
      surveyId: 'BinaryChoice',
      initialDelay: 2,
      closeDelay: 15,
      askMeLaterDelay: 10,
    ),
    onClose: onClose,
    onSend: onSend,
    onAskMeLater: onAskMeLater,
  );

  @override
  _SurveyBinaryChoiceState createState() => _SurveyBinaryChoiceState();
}

class _SurveyBinaryChoiceState extends BaseSurveyState<SurveyBinaryChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
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
                  Text(
                    AppLocalizations.of(context).translate('access_purchase_links'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildOption('NO', Icons.sentiment_very_dissatisfied_rounded, Colors.red),
                      buildOption('YES', Icons.sentiment_very_satisfied_rounded, Colors.orange),
                    ],
                  ),
                  SizedBox(height: 30),
                  buildButtons(),
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
}
