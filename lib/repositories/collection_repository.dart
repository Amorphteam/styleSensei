
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:style_sensei/models/Collection_model.dart';

import '../models/ProductsModel.dart';

class CollectionRepository {
  final String apiUrl = 'http://stylesensei.net:8282/api/v1/';

  Future<CollectionModel> fetchCollectionModel() async {
    String pathUrl = 'collection';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return CollectionModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ProductsModel> fetchProductModel(int collectionId) async {
    String pathUrl = 'collection/view/$collectionId';
    final response = await http.get(Uri.parse(apiUrl+pathUrl));
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      print('aaa ${jsonMap}');
      return ProductsModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

}
