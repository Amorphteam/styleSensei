import '../new_models/product.dart';

/// products : [{"id":16,"name":"Florencia Track Pants","description":"","category_id":"30493071","crawler_id":76818,"pictures":"https://pa.namshicdn.com/product/A1/69608W/1-zoom-desktop.jpg,https://pa.namshicdn.com/product/A1/69608W/2-zoom-desktop.jpg,https://pa.namshicdn.com/product/A1/69608W/3-zoom-desktop.jpg,https://pa.namshicdn.com/product/A1/69608W/4-zoom-desktop.jpg,https://pa.namshicdn.com/product/A1/69608W/5-zoom-desktop.jpg","corresponding_url":"https://en-ae.namshi.com/buy-the-upside-florencia-track-pants-w806961a.html","created_at":"2023-10-21T04:50:51.389025Z","modified_at":"2023-11-11T11:03:19.354245Z","category":{"id":"30493071","name":"Pants","parent_id":"62676681","created_at":"2023-10-31T05:45:20.505819Z","modified_at":"2023-10-31T05:45:20.50582Z","parent":{"id":"62676681","name":"Pants And Shorts","parent_id":"52839691","created_at":"2023-08-20T12:22:44.92617Z","modified_at":"2023-10-31T05:45:45.695534Z","parent":{"id":"52839691","name":"Clothing","parent_id":"","created_at":"2023-07-28T18:03:21.829076Z","modified_at":"2023-08-20T12:24:53.472878Z"}}},"attributes":[{"product_id":16,"attribute_id":119,"value":"navy","attribute":{"name":"Color","admin_name":"Color","image_url":""}},{"product_id":16,"attribute_id":58,"value":"Baggy Pants","attribute":{"name":"Silhouettes Of Pant","admin_name":"Silhouettes Of Pant","image_url":""}},{"product_id":16,"attribute_id":71,"value":"Sweatpants","attribute":{"name":"Pants Types","admin_name":"Pants Types","image_url":""}},{"product_id":16,"attribute_id":43,"value":"Full Length","attribute":{"name":"Lengths Of Pant","admin_name":"Lengths Of Pant","image_url":""}}]},{"id":17,"name":"High Waist Leggings","description":"","category_id":"30493071","crawler_id":76811,"pictures":"https://pa.namshicdn.com/product/A3/437811W/1-zoom-desktop.jpg,https://pa.namshicdn.com/product/A3/437811W/2-zoom-desktop.jpg,https://pa.namshicdn.com/product/A3/437811W/3-zoom-desktop.jpg,https://pa.namshicdn.com/product/A3/437811W/4-zoom-desktop.jpg","corresponding_url":"https://en-ae.namshi.com/buy-mango-high-waist-leggings-w1187343a.html","created_at":"2023-10-21T04:50:51.411966Z","modified_at":"2023-11-11T11:03:19.373384Z","category":{"id":"30493071","name":"Pants","parent_id":"62676681","created_at":"2023-10-31T05:45:20.505819Z","modified_at":"2023-10-31T05:45:20.50582Z","parent":{"id":"62676681","name":"Pants And Shorts","parent_id":"52839691","created_at":"2023-08-20T12:22:44.92617Z","modified_at":"2023-10-31T05:45:45.695534Z","parent":{"id":"52839691","name":"Clothing","parent_id":"","created_at":"2023-07-28T18:03:21.829076Z","modified_at":"2023-08-20T12:24:53.472878Z"}}},"attributes":[{"product_id":17,"attribute_id":71,"value":"Leggings","attribute":{"name":"Pants Types","admin_name":"Pants Types","image_url":""}},{"product_id":17,"attribute_id":119,"value":"grey","attribute":{"name":"Color","admin_name":"Color","image_url":""}},{"product_id":17,"attribute_id":58,"value":"Slim Fit Pants","attribute":{"name":"Silhouettes Of Pant","admin_name":"Silhouettes Of Pant","image_url":""}},{"product_id":17,"attribute_id":43,"value":"Full Length","attribute":{"name":"Lengths Of Pant","admin_name":"Lengths Of Pant","image_url":""}}]}]

class ProductsTemp {
  ProductsTemp({
    required List<Product> products,
  }) : _products = products;

  factory ProductsTemp.fromJson(Map<String, dynamic> json) {
    final List<Product> productsList = (json['products'] as List<dynamic>)
        .map((item) => Product.fromJson(item))
        .toList();

    return ProductsTemp(products: productsList);
  }

  final List<Product> _products;

  List<Product> get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['products'] = _products.map((v) => v.toJson()).toList();
    return map;
  }

  ProductsTemp copyWith({
    List<Product>? products,
  }) {
    return ProductsTemp(
      products: products ?? _products,
    );
  }
}
