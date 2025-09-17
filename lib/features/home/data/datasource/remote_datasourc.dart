import 'package:dio/dio.dart';
import 'package:ecommerce_sample/core/network/api_constant.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(ApiConstants.categoriesEndpoint);
      
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = response.data;
        return categoriesJson.map((category) => CategoryModel.fromJson(category as String)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(ApiConstants.productsEndpoint);
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson.map((product) => ProductModel.fromJson(product as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
