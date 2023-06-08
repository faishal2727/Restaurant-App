import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/detail_restaurant.dart';
import '../model/restaurant.dart';

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final restaurants = data['restaurants'] as List<dynamic>;
      return restaurants;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<dynamic>> searchRestaurants(String query) async {
    final url = Uri.parse('$baseUrl/search?q=$query');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final restaurants = data['restaurants'] as List<dynamic>;
      return restaurants;
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<Map<String, dynamic>> fetchDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/:id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch detail');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
