import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];
      return products.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed to load product detail');
    }
  }
  Future<List<String>> getAllCategories() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/category-list'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products/category/$category'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data['products'];
      return products.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }


}
