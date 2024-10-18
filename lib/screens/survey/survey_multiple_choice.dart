import 'package:flutter/material.dart';
import '../../utils/AppLocalizations.dart';
import 'survey_config.dart';
import 'base_survey_widget.dart';

class SurveyMultipleChoice extends BaseSurveyWidget {
  SurveyMultipleChoice({
    required VoidCallback onClose,
    required VoidCallback onSend,
    required VoidCallback onAskMeLater,
  }) : super(
    surveyConfig: SurveyConfig(
      surveyId: 'MultipleChoice',
      initialDelay: 5,
      closeDelay: 25,
      askMeLaterDelay: 12,
    ),
    onClose: onClose,
    onAskMeLater: onAskMeLater,
    onSend: onSend,
  );

  @override
  _SurveyMultipleChoiceState createState() => _SurveyMultipleChoiceState();
}

class _SurveyMultipleChoiceState extends BaseSurveyState<SurveyMultipleChoice> {
  final TextEditingController _suggestionController = TextEditingController();
  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.8,
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        AppLocalizations.of(context).translate('which_method_prefer'),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ..._buildOptions(),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).translate('other_suggestions'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _suggestionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: AppLocalizations.of(context).translate('type_answer'),
                        ),
                        maxLines: 3,
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
        ),
      ),
    );
  }

  List<Widget> _buildOptions() {
    List<String> options = [
      'quick_tips',
      'full_tutorials',
      'video_guides',
      'ai_chat_styling',
      'none',
    ];

    return options.map((optionKey) {
      return GestureDetector(
        onTap: () => handleOptionSelection(optionKey),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedOption == optionKey ? Theme.of(context).colorScheme.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            AppLocalizations.of(context).translate(optionKey),
            style: TextStyle(
              color: selectedOption == optionKey ? Colors.white : Colors.black,
            ),
            textAlign: isRtl ? TextAlign.right : TextAlign.left,
          ),
        ),
      );
    }).toList();
  }
}
