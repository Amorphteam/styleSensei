import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> loadConfig() async {
  final configString = await rootBundle.loadString('assets/json/config.json');
  return json.decode(configString);
}
Future<String> getStyleDetails(String prompt) async {
  final config = await loadConfig();
  final apiKey = config['OPENAI_API_KEY'];
  if (apiKey == null) {
    throw Exception('API Key is not set in the configuration file.');
  }
  final url = Uri.parse('https://api.openai.com/v1/chat/completions');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'system',
          'content': 'You are a helpful assistant.'
        },
        {
          'role': 'user',
          'content': prompt
        }
      ],
      'max_tokens': 250,
      'n': 1,
      'stop': null,
      'temperature': 0.7,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    return data['choices'][0]['message']['content'].trim();
  } else {
    throw Exception('Failed to load data: ${response.body}');
  }
}
