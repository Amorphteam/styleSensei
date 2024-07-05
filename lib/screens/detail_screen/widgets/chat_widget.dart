import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../models/ProductsModel.dart';
import '../../../utils/AppLocalizations.dart';
import '../../../utils/ai_helper.dart';
import '../../../utils/untitled.dart';

class ChatWidget extends StatefulWidget {
  final ProductsModel? collectionDetail;

  ChatWidget({required this.collectionDetail});

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _showResponse = false;
  String _response = "";
  String _selectedQuestion = "";

  void _onTextChanged(String text) {
    setState(() {
      _showResponse = false;
    });
  }

  void _askStyleQuestion() async {
    final prompt = createPrompt();
    final response = await getStyleDetails(prompt);
    setState(() {
      _response = response;
      _showResponse = true;
    });
  }

  String createPrompt() {
    var detail = widget.collectionDetail;
    var tags = detail?.collection?.tags?.entries.map((e) => e.value.join(', ')).join(', ') ?? '';
    var allDesc = detail?.collection?.description ?? '';
    var desc = getDesPart(allDesc, 'desc', Localizations.localeOf(context).languageCode);
    var bodyShape = getDesPart(allDesc, 'body_shape', Localizations.localeOf(context).languageCode);
    var situation = getDesPart(allDesc, 'situation', Localizations.localeOf(context).languageCode);
    var design = getDesPart(allDesc, 'design', Localizations.localeOf(context).languageCode);

    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(_controller.text);

    return "$tags\n${_controller.text}\nDescription: $desc\nBody Shape: $bodyShape\nSituation: $situation\nDesign: $design\nLanguage: ${isArabic ? 'Arabic' : 'English'}";
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).translate('ask_ai_title'),
        ),
        Gap(10),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).translate('ai_field_hint'),
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/images/ai.svg', color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
              icon: SvgPicture.asset(
                'assets/images/arrow_top.svg',
              ),
              onPressed: () {
                _askStyleQuestion();
                setState(() {
                  _selectedQuestion = _controller.text;
                  _showResponse = true;
                  _response = '';
                });
              },
            )
                : null,
            filled: true,
            fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Adjust this value to change the height

          ),
          onChanged: _onTextChanged,
        ),
        if (_showResponse)
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(top: 16),
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedQuestion,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onBackground),
                      onPressed: () {
                        setState(() {
                          _showResponse = false;
                          _controller.clear();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  _response,
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
