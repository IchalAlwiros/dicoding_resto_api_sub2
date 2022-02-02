import 'dart:convert';
import 'package:dicoding_submission_restoapi/data/model/restaurant_%20detail_model.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_list_model.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_post_model.dart';
import 'package:dicoding_submission_restoapi/data/model/restaurant_search_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService with ChangeNotifier{
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String baseUrlImage = '${_baseUrl}images/small/';

  Future<RestaurantResult> getListResto() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  var data = [];
  List<RestaurantSearchResult> results = [];
  Future<List<RestaurantSearchResult>> getSearchResto({String? name}) async {
    var urlSearch = Uri.parse(_baseUrl + "search?q=$name");
    try {
      var response = await http.get(urlSearch);
      if (response.statusCode == 200) {
        data = json.decode(response.body)['restaurants'];
        results = data.map((e) => RestaurantSearchResult.fromJson(e)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  Future<RestaurantDetailResult> getDetailResto({required String? id}) async {
    final urlDetail = Uri.parse(_baseUrl + "detail/$id");
    final response = await http.get(urlDetail);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantPostResult> createPostReview({String? id,String? name, String? review}) async {
    final response = await http.post(
      Uri.parse('https://restaurant-api.dicoding.dev/review'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id!,
        'name': name!,
        'review': review!,
      }),
    );
    if (response.statusCode == 201) {
      print(response.body);
      return RestaurantPostResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create review.');
    }
  }
}
