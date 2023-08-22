
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:style_sensei/models/Collection_model.dart';

class CollectionRepository {
  final String apiUrl = 'http://stylesensei.net:8282/api/v1/collection';

  Future<CollectionModel> fetchCollectionModel() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return CollectionModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
