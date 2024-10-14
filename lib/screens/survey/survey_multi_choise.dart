import 'package:flutter/material.dart';

class NewSurveyPage extends StatefulWidget {
  final VoidCallback onClose;

  NewSurveyPage({required this.onClose});

  @override
  _NewSurveyPageState createState() => _NewSurveyPageState();
}

class _NewSurveyPageState extends State<NewSurveyPage> {
  String selectedOption = '';
  TextEditingController _suggestionController = TextEditingController();

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
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50), // For space between top and question text
                    Text(
                      'Which method do you prefer for receiving styling education?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    // Multiple-choice options with full width
                    ..._buildOptions(),

                    SizedBox(height: 20),

                    // TextField for other suggestions
                    Text(
                      'Other suggestions?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _suggestionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type your answer here...',
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
                            'Ask me later',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "Send" action (submit survey)
                            if (selectedOption.isNotEmpty || _suggestionController.text.isNotEmpty) {
                              // Submit the selected option and the suggestion (if any)
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
      ),
    );
  }

  // Method to build the multiple-choice options with full width
  List<Widget> _buildOptions() {
    List<String> options = [
      'Quick tips',
      'Full tutorials',
      'Video guides',
      'AI chat for styling advice',
      'None'
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
            textAlign: TextAlign.left, // Align text to the left
          ),
        ),
      );
    }).toList();
  }
}
