
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:style_sensei/models/Collection_model.dart';
import 'package:style_sensei/models/ProtuctsTemp.dart';

import '../models/ProductsModel.dart';
import '../new_models/collection_item.dart';

class CollectionRepository {
  final String apiUrl = 'http://stylesensei.net:8282/api/v1/';

  Future<CollectionModel> fetchCollectionModel(List<int> collectionTags) async {
    String tagsQuery = collectionTags.join(',');
    String pathUrl = 'collection?limit=300&tags=$tagsQuery';
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
      return ProductsModel.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<CollectionItem>> fetchCollectionItems(int collectionId) async {
    String pathUrl = 'collection/$collectionId/items';
    final Uri fullUrl = Uri.parse(apiUrl + pathUrl);

    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"favorite_attributes": {}});

    final response = await http.post(fullUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['collection_items'] as List<dynamic>;
      return jsonList.map((jsonItem) => CollectionItem.fromJson(jsonItem as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  }


  Future<ProductsTemp> fetchProductModelByIds(List<int> collectionId) async {
    String idsQuery = collectionId.join(',');
    String pathUrl = 'product/list/get-by-ids?ids=$idsQuery';
    final response = await http.get(Uri.parse(apiUrl + pathUrl));
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ProductsTemp.fromJson(jsonMap);
    } else {
      throw Exception('Failed to fetch data');
    }
  }


}
