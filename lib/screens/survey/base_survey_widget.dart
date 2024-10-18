import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/AppLocalizations.dart';
import 'survey_config.dart';
import 'survey_response_service.dart';

abstract class BaseSurveyWidget extends StatefulWidget {
  final SurveyConfig surveyConfig;
  final VoidCallback onClose;
  final VoidCallback onSend;
  final VoidCallback onAskMeLater;

  BaseSurveyWidget({
    required this.surveyConfig,
    required this.onClose,
    required this.onSend,
    required this.onAskMeLater,
  });
}

abstract class BaseSurveyState<T extends BaseSurveyWidget> extends State<T> {
  String selectedOption = '';
  String hoveredOption = '';
  final SurveyResponseService surveyResponseService = SurveyResponseService();

  void handleOptionSelection(String optionKey) {
    setState(() {
      selectedOption = optionKey;
    });
  }

  Future<void> sendSurveyResponse() async {
    if (selectedOption.isNotEmpty) {
      await surveyResponseService.sendSurveyResponse(
        widget.surveyConfig.surveyId,
        selectedOption,
      );
      widget.onClose();
    }
  }

  Widget buildOption(String optionKey, IconData icon, Color activeColor) {
    return GestureDetector(
      onTap: () => handleOptionSelection(optionKey),
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => hoveredOption = optionKey),
            onExit: (_) => setState(() => hoveredOption = ''),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (selectedOption == optionKey || hoveredOption == optionKey)
                    ? activeColor.withOpacity(0.2)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: selectedOption == optionKey ? activeColor : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(AppLocalizations.of(context).translate(optionKey)),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: widget.onAskMeLater,
          child: Text(
            AppLocalizations.of(context).translate('ask_me_later'),
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            sendSurveyResponse();
          },
          child: Text(AppLocalizations.of(context).translate('send_bu')),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}
