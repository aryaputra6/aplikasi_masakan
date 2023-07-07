import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal.dart';

class MealApi {
  static const String baseUrl =
      'https://www.themealdb.com/api/json/v1/1'; //untuk menampilkan list makanan

  static Future<List<Meal>> getMeals() async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=Seafood'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(response.body); //membuat variabel data
      final List<dynamic> meals = data['meals']; //membuat variabel meals
      return meals
          .map((json) => Meal.fromJson(json))
          .toList(); //membuat list makanan
    } else {
      throw Exception('Failed to load meals'); //untuk memberi pesan error
    }
  } //agar dapat menampilkan list makanan

  static Future<Meal> getMealDetails(String mealId) async {
    //untuk menampilkan detail makanan
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$mealId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> meals = data['meals'];
      final json = meals[0];
      return Meal.fromJson(json);
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}//untuk membuat class MealApi
