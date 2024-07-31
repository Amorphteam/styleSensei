import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:style_sensei/models/ProductsModel.dart';
import 'package:style_sensei/new_models/collection_item.dart';

class CacheManager {
  static const String cacheTimestampKey = 'cache_timestamp';

  static Future<void> saveCollectionDetail(int collectionId, ProductsModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('collection_detail_$collectionId', json.encode(data.toJson()));
    await prefs.setInt('collection_detail_timestamp_$collectionId', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> saveCollectionItems(int collectionId, List<CollectionItem> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('collection_items_$collectionId', json.encode(data.map((item) => item.toJson()).toList()));
    await prefs.setInt('collection_items_timestamp_$collectionId', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<ProductsModel?> getCollectionDetail(int collectionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt('collection_detail_timestamp_$collectionId');
    if (timestamp != null) {
      // Check if the cache is expired (e.g., 1 hour)
      if (DateTime.now().millisecondsSinceEpoch - timestamp < 3600000) {
        String? jsonData = prefs.getString('collection_detail_$collectionId');
        if (jsonData != null) {
          return ProductsModel.fromJson(json.decode(jsonData));
        }
      } else {
        // Cache expired, clear it
        await clearCollectionDetailCache(collectionId);
      }
    }
    return null;
  }

  static Future<List<CollectionItem>?> getCollectionItems(int collectionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt('collection_items_timestamp_$collectionId');
    if (timestamp != null) {
      // Check if the cache is expired (e.g., 1 hour)
      if (DateTime.now().millisecondsSinceEpoch - timestamp < 3600000) {
        String? jsonData = prefs.getString('collection_items_$collectionId');
        if (jsonData != null) {
          return (json.decode(jsonData) as List).map((item) => CollectionItem.fromJson(item)).toList();
        }
      } else {
        // Cache expired, clear it
        await clearCollectionItemsCache(collectionId);
      }
    }
    return null;
  }

  static Future<void> clearCollectionDetailCache(int collectionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('collection_detail_$collectionId');
    await prefs.remove('collection_detail_timestamp_$collectionId');
  }

  static Future<void> clearCollectionItemsCache(int collectionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('collection_items_$collectionId');
    await prefs.remove('collection_items_timestamp_$collectionId');
  }
}
