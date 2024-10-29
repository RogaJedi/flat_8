import 'package:dio/dio.dart';
import 'notes.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8080';

  Future<List<Note>> getProducts() async {
    try {
      final response = await _dio.get('$_baseUrl/products');
      if (response.statusCode == 200) {
        List<Note> products = (response.data as List)
            .map((product) => Note.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  //1. POST - Create a product
  Future<Note> createProduct(Note product) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/products',
        data: product.toJson(),
      );
      if (response.statusCode == 201) {
        return Note.fromJson(response.data);
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }



  // 2. GET - Get a product with a certain id
  Future<Note> getProduct(String id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');
      if (response.statusCode == 200) {
        return Note.fromJson(response.data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  //3. PUT - Update info of a product with a certain id
  Future<Note> updateProduct(String id, Note updatedProduct) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/products/$id',
        data: updatedProduct.toJson(),
      );
      if (response.statusCode == 200) {
        return Note.fromJson(response.data);
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // 4. DELETE - Delete a product with a certain id
  Future<void> deleteProduct(String id) async {
    try {
      final response = await _dio.delete('$_baseUrl/products/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
