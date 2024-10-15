import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyMultipleChoice extends StatefulWidget {
  final VoidCallback onClose;

  SurveyMultipleChoice({required this.onClose});

  @override
  _NewSurveyPageState createState() => _NewSurveyPageState();
}

class _NewSurveyPageState extends State<SurveyMultipleChoice> {
  String selectedOption = '';
  TextEditingController _suggestionController = TextEditingController();
  bool isRtl = false;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void handleOptionSelection(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  // Method to send data to Firestore
  Future<void> _sendSurveyResponse() async {
    try {
      await _firestore.collection('survey_responses').add({
        'survey_type': 'MultipleChoice',  // You can use different survey types
        'response': selectedOption,
        'suggestion': _suggestionController.text.isNotEmpty ? _suggestionController.text : null,
        'timestamp': Timestamp.now(),
      });
      widget.onClose();
    } catch (e) {
      print("Error saving survey response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current locale is Arabic or another RTL language
    isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Allows the layout to adjust when the keyboard appears
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView( // Make the container scrollable
              child: Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Text(
                          AppLocalizations.of(context).translate('which_method_prefer'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),

                        // Multiple-choice options with full width
                        ..._buildOptions(),

                        SizedBox(height: 20),

                        // TextField for other suggestions
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

                        // "Ask me later" and "Send" buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: widget.onClose, // Close the survey
                              child: Text(
                                AppLocalizations.of(context).translate('ask_me_later'),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle "Send" action (submit survey)
                                if (selectedOption.isNotEmpty || _suggestionController.text.isNotEmpty) {
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
          ),
        ),
      ),
    );
  }

  // Method to build the multiple-choice options with full width
  List<Widget> _buildOptions() {
    List<String> options = [
      AppLocalizations.of(context).translate('quick_tips'),
      AppLocalizations.of(context).translate('full_tutorials'),
      AppLocalizations.of(context).translate('video_guides'),
      AppLocalizations.of(context).translate('ai_chat_styling'),
      AppLocalizations.of(context).translate('none')
    ];

    return options.map((option) {
      return GestureDetector(
        onTap: () => handleOptionSelection(option),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(12),
          width: double.infinity, // Make sure the option takes full width
          decoration: BoxDecoration(
            color: selectedOption == option ? Theme.of(context).colorScheme.primary : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            option,
            style: TextStyle(
              color: selectedOption == option ? Colors.white : Colors.black,
            ),
            textAlign: isRtl ? TextAlign.right : TextAlign.left, // Align text based on direction
          ),
        ),
      );
    }).toList();
  }
}
