import 'package:flutter/material.dart';
import 'package:style_sensei/screens/survey/survey_response_service.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CombinedSurveyScreen extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSend;

  CombinedSurveyScreen({required this.onClose, required this.onSend});

  @override
  _CombinedSurveyScreenState createState() => _CombinedSurveyScreenState();
}

class _CombinedSurveyScreenState extends State<CombinedSurveyScreen> {
  int currentStep = 0;
  String selectedOption = '';
  bool isRtl = false;
  TextEditingController _suggestionController = TextEditingController();
  final SurveyResponseService surveyResponseService = SurveyResponseService();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of survey steps
  final List<String> surveyQuestions = [
    'outfit_alignment',       // Multi-step Survey
    'discover_clothing_suitability', // Multi-step Survey
    'which_method_prefer',    // Multiple Choice Survey
    'satisfaction_question',    // Satisfaction Rating Survey
    'access_purchase_links',  // Binary Choice Survey
  ];

  // Handles the option selection for each step
  void handleOptionSelection(String optionKey) {
    setState(() {
      selectedOption = optionKey;
    });
  }

  // Sends survey response to Firestore
  Future<void> _sendSurveyResponse() async {
    final responses = _buildResponses();
    final isSuccess = await surveyResponseService.sendSurveyResponse(
      'CombinedSurvey',
      responses.toString(), // Convert the responses map to a string
    );

    if (isSuccess) {
      if (mounted) {
        widget.onSend();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).translate('feedback_received'),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        );
      }
    } else {
      if (mounted) {
        widget.onClose();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).translate('firebase_error'),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Building survey responses for each step
  Map<String, dynamic> _buildResponses() {
    return {
      surveyQuestions[currentStep]: selectedOption,
      'suggestion': _suggestionController.text.isNotEmpty ? _suggestionController.text : null,
    };
  }

  // Move to the next step
  void nextStep() {
    if (currentStep < surveyQuestions.length - 1) {
      setState(() {
        currentStep++;
        selectedOption = ''; // Reset the selection for each step
      });
    } else {
      _sendSurveyResponse();
    }
  }

  // Move to the previous step
  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        selectedOption = ''; // Reset the selection when moving back
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if the language is RTL
    isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      resizeToAvoidBottomInset: true, // Ensures content adjusts when keyboard appears
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
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

                          // Progress Indicator
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
                                        : Colors.grey.shade300,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Display survey question for the current step
                          Text(
                            AppLocalizations.of(context).translate(surveyQuestions[currentStep]),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),

                          // Render different options based on the current step
                          if (currentStep == 0 || currentStep == 1) ...[
                            _buildEmojiOptions(),
                          ] else if (currentStep == 2) ...[
                            _buildMultipleChoiceOptions(),
                            SizedBox(height: 20),
                            TextField(
                              controller: _suggestionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: AppLocalizations.of(context).translate('type_answer'),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                            ),
                          ] else if (currentStep == 3) ...[
                            _buildSatisfactionRatingOptions(),
                          ] else if (currentStep == 4) ...[
                            _buildBinaryChoiceOptions(),
                          ],
                          SizedBox(height: 30),

                          // Navigation Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (currentStep > 0)
                                TextButton(
                                  onPressed: previousStep,
                                  child: Text(
                                    AppLocalizations.of(context).translate('previous'),
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                ),
                              if (currentStep == 0) SizedBox(),

                              ElevatedButton(
                                onPressed: selectedOption.isNotEmpty || currentStep == 2 ? nextStep : null,
                                child: Text(
                                  currentStep == surveyQuestions.length - 1
                                      ? AppLocalizations.of(context).translate('send_bu')
                                      : AppLocalizations.of(context).translate('next'),
                                ),
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

                      // Close Icon
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
          },
        ),
      ),
    );
  }

  // Build multiple-choice options
  Widget _buildMultipleChoiceOptions() {
    List<String> options = [
      'quick_tips',
      'full_tutorials',
      'video_guides',
      'ai_chat_styling',
      'none'
    ];

    return Column(
      children: options.map((optionKey) {
        return GestureDetector(
          onTap: () => handleOptionSelection(optionKey),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: selectedOption == optionKey ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withAlpha(9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              AppLocalizations.of(context).translate(optionKey),
              textAlign: isRtl ? TextAlign.right : TextAlign.left,
            ),
          ),
        );
      }).toList(),
    );
  }

  // Build emoji options for multi-step satisfaction rating
  Widget _buildEmojiOptions() {
    List<Map<String, dynamic>> emojiOptions = [
      {'key': 'way_off', 'icon': Icons.sentiment_very_dissatisfied_rounded, 'color': Colors.red},
      {'key': 'meh_kinda', 'icon': Icons.sentiment_neutral_rounded, 'color': Colors.blue},
      {'key': 'totally_me', 'icon': Icons.sentiment_satisfied_alt_rounded, 'color': Colors.orange},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: emojiOptions.map((option) {
        return GestureDetector(
          onTap: () => handleOptionSelection(option['key']),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedOption == option['key'] ? option['color'].withOpacity(0.2) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option['icon'],
                  size: 40,
                  color: selectedOption == option['key'] ? option['color'] : Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Text(AppLocalizations.of(context).translate(option['key'])),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Build binary choice options
// Build binary choice options
  Widget _buildBinaryChoiceOptions() {
    List<Map<String, dynamic>> binaryOptions = [
      {
        'key': 'YES',
        'label': AppLocalizations.of(context).translate('YES'),
        'icon': Icons.sentiment_satisfied_alt_rounded,  // Icon for "Yes"
        'color': Colors.green,  // Color for "Yes"
      },
      {
        'key': 'NO',
        'label': AppLocalizations.of(context).translate('NO'),
        'icon': Icons.sentiment_very_dissatisfied_rounded,  // Icon for "No"
        'color': Colors.red,  // Color for "No"
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Add vertical padding to avoid overflow
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: binaryOptions.map((option) {
          return GestureDetector(
            onTap: () => handleOptionSelection(option['key']),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedOption == option['key'] ? option['color'].withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    option['icon'],  // Icon for Yes/No
                    size: 40,
                    color: selectedOption == option['key'] ? option['color'] : Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  option['label'],
                  style: TextStyle(
                    color: selectedOption == option['key'] ? option['color'] : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Build emoji options for satisfaction rating survey
  Widget _buildSatisfactionRatingOptions() {
    List<Map<String, dynamic>> emojiOptions = [
      {'key': 'nope', 'icon': Icons.sentiment_very_dissatisfied_rounded, 'color': Colors.red},
      {'key': 'okay', 'icon': Icons.sentiment_neutral_rounded, 'color': Colors.blue},
      {'key': 'agree', 'icon': Icons.sentiment_satisfied_alt_rounded, 'color': Colors.orange},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: emojiOptions.map((option) {
        return GestureDetector(
          onTap: () => handleOptionSelection(option['key']),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedOption == option['key'] ? option['color'].withOpacity(0.2) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option['icon'],
                  size: 40,
                  color: selectedOption == option['key'] ? option['color'] : Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Text(AppLocalizations.of(context).translate(option['key'])),
            ],
          ),
        );
      }).toList(),
    );
  }
}
