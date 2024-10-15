import 'package:flutter/material.dart';
import 'package:style_sensei/utils/AppLocalizations.dart';

class SurveySatisfactionRating extends StatefulWidget {
  final VoidCallback onClose;

  SurveySatisfactionRating({required this.onClose});

  @override
  _SurveyTrueFalseState createState() => _SurveyTrueFalseState();
}

class _SurveyTrueFalseState extends State<SurveySatisfactionRating> {
  String selectedOption = '';
  String hoveredOption = '';

  void handleOptionSelection(String option) {
    setState(() {
      selectedOption = option;
    });
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
                        onTap: () => handleOptionSelection(AppLocalizations.of(context).translate('nope')),
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = AppLocalizations.of(context).translate('nope')),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == AppLocalizations.of(context).translate('nope') || hoveredOption == AppLocalizations.of(context).translate('nope')
                                      ? Colors.red.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_very_dissatisfied_rounded,
                                  size: 40,
                                  color: selectedOption == AppLocalizations.of(context).translate('nope') ? Colors.red : Colors.grey,
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
                        onTap: () => handleOptionSelection(AppLocalizations.of(context).translate('okay')),
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = AppLocalizations.of(context).translate('okay')),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == AppLocalizations.of(context).translate('okay') || hoveredOption == AppLocalizations.of(context).translate('okay')
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_neutral_rounded,
                                  size: 40,
                                  color: selectedOption == AppLocalizations.of(context).translate('okay') ? Colors.blue : Colors.grey,
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
                        onTap: () => handleOptionSelection(AppLocalizations.of(context).translate('agree')),
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = AppLocalizations.of(context).translate('agree')),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == AppLocalizations.of(context).translate('agree') || hoveredOption == AppLocalizations.of(context).translate('agree')
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_satisfied_alt_rounded,
                                  size: 40,
                                  color: selectedOption == AppLocalizations.of(context).translate('agree') ? Colors.orange : Colors.grey,
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
                          // Handle "Send" action (submit survey)
                          if (selectedOption.isNotEmpty) {
                            widget.onClose(); // Close survey after submission
                          }
                        },
                        child: Text(AppLocalizations.of(context).translate('send_bu')),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.black,
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
