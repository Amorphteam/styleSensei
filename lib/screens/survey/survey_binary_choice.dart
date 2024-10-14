import 'package:flutter/material.dart';

class SurveyBinaryChoice extends StatefulWidget {
  final VoidCallback onClose;

  SurveyBinaryChoice({required this.onClose});

  @override
  _SurveyTrueFalseState createState() => _SurveyTrueFalseState();
}

class _SurveyTrueFalseState extends State<SurveyBinaryChoice> {
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
                    'Have you easily accessed the purchase links for your favorite items through the app?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Emoji Options with Hover and Selection Effect Around Icon Only
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // "Nope" Option
                      GestureDetector(
                        onTap: () => handleOptionSelection('Nope'),
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = 'Nope'),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == 'Nope' || hoveredOption == 'Nope'
                                      ? Colors.red.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_very_dissatisfied_rounded,
                                  size: 40,
                                  color: selectedOption == 'Nope' ? Colors.red : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Space between icon and text
                            Text('Nope'),
                          ],
                        ),
                      ),

                      // "Yes" Option
                      GestureDetector(
                        onTap: () => handleOptionSelection('Yes'),
                        child: Column(
                          children: [
                            MouseRegion(
                              onEnter: (_) => setState(() => hoveredOption = 'Yes'),
                              onExit: (_) => setState(() => hoveredOption = ''),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: selectedOption == 'Yes' || hoveredOption == 'Yes'
                                      ? Colors.orange.withOpacity(0.2)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sentiment_very_satisfied_rounded,
                                  size: 40,
                                  color: selectedOption == 'Yes' ? Colors.orange : Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Space between icon and text
                            Text('Yes'),
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
                          'Ask me later',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle "Send" action (submit survey)
                          if (selectedOption.isNotEmpty) {
                            // You can store this result in your backend
                            widget.onClose(); // Close survey after submission
                          }
                        },
                        child: Text('Send'),
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
